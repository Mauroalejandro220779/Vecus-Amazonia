library(dplyr)
library(readr)
library(writexl)
library(tidyr)

# ===== 1. Parámetros y datos económicos =====
valor_ha_cop_bosque <- 9618563
valor_ha_cop_agua   <- 68962
tasa_descuento <- 0.08
anio_base <- 2023

# PIB total Amazonía (en COP) y PIB Colombia
pib_amazonia <- 2.7074e+13   # 
pib_colombia <- 1.490309e+15    # 

# ===== 2. Cargar y procesar datos =====
cambios <- read.csv("C:/2025/Socrates Data/amazonia/cambios_mapbiomaslimiteamazonia.csv",
                    sep = ";", stringsAsFactors = FALSE)

diccionario <- read.csv("C:/2025/Socrates Data/amazonia/diccionario_clases.csv",
                        stringsAsFactors = FALSE)

# Limpieza y unión
cambios <- cambios %>%
  mutate(
    class_level_2_from = trimws(class_level_2_from),
    class_level_2_to   = trimws(class_level_2_to),
    bioma = "Amazonía"     # reemplaza/estandariza ámbito de análisis
  ) %>%
  left_join(diccionario, by = c("class_level_2_from" = "class_level_2_name")) %>%
  rename(origen_simplificado = clase_simplificada) %>%
  left_join(diccionario, by = c("class_level_2_to" = "class_level_2_name")) %>%
  rename(destino_simplificado = clase_simplificada)

# Procesar periodos
periodos <- paste0("p", 2000:2022, "_", 2001:2023)
extraer_anio <- function(periodo) as.numeric(substr(periodo, nchar(periodo)-3, nchar(periodo)))

for(p in periodos){
  if(p %in% names(cambios)){
    cambios[[p]] <- as.numeric(gsub(",", ".", cambios[[p]]))
  }
}

# ===== 3. Cálculo principal (región completa) =====
resultado_final <- cambios %>%
  filter(
    origen_simplificado %in% c("Bosque", "Agua"),
    destino_simplificado %in% c("Agricultura", "Urbano", "Minería", "Área sin vegetación")
  ) %>%
  pivot_longer(
    cols = all_of(periodos[periodos %in% names(cambios)]),
    names_to = "periodo",
    values_to = "area_ha"
  ) %>%
  mutate(
    anio = extraer_anio(periodo),
    valor_por_ha = ifelse(origen_simplificado == "Bosque", valor_ha_cop_bosque, valor_ha_cop_agua),
    perdida_cop = area_ha * valor_por_ha,
    perdida_mil_millones = perdida_cop / 1e9
  ) %>%
  group_by(bioma, periodo, anio, origen_simplificado, destino_simplificado) %>%
  summarise(
    area_ha = sum(area_ha, na.rm = TRUE),
    perdida_cop = sum(perdida_cop, na.rm = TRUE),
    perdida_mil_millones = sum(perdida_mil_millones, na.rm = TRUE),
    .groups = "drop"
  )

# ===== 4. Porcentajes vs PIB Amazonía y Colombia =====
porcentajes_correctos <- resultado_final %>%
  group_by(bioma, periodo, anio) %>%
  summarise(
    perdida_total = sum(perdida_cop, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    porcentaje_pib_amazonia = (perdida_total / pib_amazonia) * 100,
    porcentaje_pib_colombia = (perdida_total / pib_colombia) * 100
  )

# ===== 5. Cálculo VPN (resumen) =====
resumen_vpn <- resultado_final %>%
  group_by(bioma) %>%
  summarise(
    total_perdida_historica = sum(perdida_cop, na.rm = TRUE),
    vpn_perdidas = sum(perdida_cop / (1 + tasa_descuento)^(anio_base - anio), na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    vpn_mil_millones = vpn_perdidas / 1e9,
    porcentaje_vpn_pib_amazonia = (vpn_perdidas / pib_amazonia) * 100,
    porcentaje_vpn_pib_colombia = (vpn_perdidas / pib_colombia) * 100
  )

# ===== 6. Resumen de pérdidas totales por origen (por periodo) =====
resumen_perdidas <- resultado_final %>%
  group_by(bioma, periodo, anio, origen_simplificado) %>%
  summarise(
    area_perdida = sum(area_ha, na.rm = TRUE),
    perdida_cop  = sum(perdida_cop, na.rm = TRUE),
    perdida_mil_millones = sum(perdida_mil_millones, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  pivot_wider(
    names_from  = origen_simplificado,
    values_from = c(area_perdida, perdida_cop, perdida_mil_millones),
    names_sep   = "_",
    values_fill = 0
  ) %>%
  mutate(
    # aliases explícitos para facilitar consumo posterior
    perdida_bosque = perdida_cop_Bosque,
    perdida_agua   = perdida_cop_Agua
  ) %>%
  arrange(periodo)

# ===== 7. Resumen de áreas por origen y destino =====
resumen_areas <- cambios %>%
  filter(
    origen_simplificado %in% c("Bosque", "Agua"),
    destino_simplificado %in% c("Agricultura", "Urbano", "Minería", "Área sin vegetación")
  ) %>%
  pivot_longer(
    cols = all_of(periodos[periodos %in% names(cambios)]),
    names_to = "periodo",
    values_to = "area_ha"
  ) %>%
  mutate(anio = extraer_anio(periodo)) %>%
  group_by(bioma, periodo, anio) %>%
  summarise(
    area_bosque         = sum(area_ha[origen_simplificado == "Bosque"], na.rm = TRUE),
    area_agua           = sum(area_ha[origen_simplificado == "Agua"], na.rm = TRUE),
    area_agricultura    = sum(area_ha[destino_simplificado == "Agricultura"], na.rm = TRUE),
    area_urbano         = sum(area_ha[destino_simplificado == "Urbano"], na.rm = TRUE),
    area_mineria        = sum(area_ha[destino_simplificado == "Minería"], na.rm = TRUE),
    area_sin_vegetacion = sum(area_ha[destino_simplificado == "Área sin vegetación"], na.rm = TRUE),
    .groups = "drop"
  )

# ===== 8. VPN anual y acumulado por origen =====
vpn_anual <- resultado_final %>%
  group_by(bioma, periodo, anio, origen_simplificado) %>%
  summarise(
    perdida_total_cop = sum(perdida_cop, na.rm = TRUE),
    vpn_total         = sum(perdida_cop / (1 + tasa_descuento)^(anio_base - anio), na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(anio, origen_simplificado) %>%
  group_by(bioma, origen_simplificado) %>%
  mutate(
    perdida_acumulada_cop = cumsum(perdida_total_cop),
    vpn_acumulado         = cumsum(vpn_total)
  ) %>%
  ungroup()

# ===== 9. Exportar =====
write_xlsx(
  list(
    "Perdidas_Anuales"      = resultado_final,
    "Porcentajes_Correctos" = porcentajes_correctos,
    "Resumen_VPN"           = resumen_vpn,
    "Resumen_Areas"         = resumen_areas,
    "Perdidas_Totales"      = resumen_perdidas,
    "VPN_Anual"             = vpn_anual
  ),
  "C:/2025/Socrates Data/amazonia/perdidas_economicas_limiteamazonia.xlsx"
)

cat("✓ Archivo exportado con 6 hojas para la Amazonía completa (bioma = 'Amazonía').\n")
