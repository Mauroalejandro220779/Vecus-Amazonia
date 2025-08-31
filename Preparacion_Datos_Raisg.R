library(dplyr)

# Cargar datos
cambios <- read.csv("C:/2025/Socrates Data/amazonia/cambios_mapbiomasamazonia.csv", sep = ";", stringsAsFactors = FALSE)
diccionario <- read.csv("C:/2025/Socrates Data/amazonia/diccionario_clases.csv", stringsAsFactors = FALSE)

# Limpiar nombres por si hay espacios extra
cambios$class_level_2_from <- trimws(cambios$class_level_2_from)
cambios$class_level_2_to <- trimws(cambios$class_level_2_to)
diccionario$class_level_2_name <- trimws(diccionario$class_level_2_name)

# Unir clase simplificada origen
cambios <- left_join(
  cambios,
  diccionario,
  by = c("class_level_2_from" = "class_level_2_name")
)
colnames(cambios)[ncol(cambios)] <- "origen_simplificado"

# Unir clase simplificada destino
cambios <- left_join(
  cambios,
  diccionario,
  by = c("class_level_2_to" = "class_level_2_name")
)
colnames(cambios)[ncol(cambios)] <- "destino_simplificado"

# Corregir notación decimal en p2010_2020 (de texto con coma a número)
cambios$p2010_2020 <- as.numeric(gsub(",", ".", cambios$p2010_2020))

# Filtrar transiciones de pérdida ecosistémica
transiciones_interes <- cambios %>%
  filter(
    origen_simplificado %in% c("Bosque", "Vegetación natural", "Agua") &
      destino_simplificado %in% c("Agricultura", "Urbano", "Minería", "Área sin vegetación")
  )

# Agrupar y resumir
resumen <- transiciones_interes %>%
  group_by(origen_simplificado, destino_simplificado) %>%
  summarise(area_ha = sum(p2010_2020, na.rm = TRUE)) %>%
  rename(
    cobertura_origen = origen_simplificado,
    cobertura_destino = destino_simplificado
  )

# Exportar
write.csv(resumen, "C:/2025/Socrates Data/amazonia/cambios_amazonia.csv", row.names = FALSE)

