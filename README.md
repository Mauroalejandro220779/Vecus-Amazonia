# Vecus-Amazonia

# 📊 VECUS: Herramienta modular para estimación de pérdida económica por deforestación en la Amazonia Colombiana a partir de datos de MapBiomas
[![Socrates Data](https://github.com/user-attachments/assets/06393ce0-b276-4e85-8aca-bdb73f99d4ec)](https://socratesdata.org/)

*Proyecto desarrollado en colaboración con [Socrates Data](https://socratesdata.org/)*

Análisis integral del impacto económico de la deforestación en la Amazonia colombiana (2001-2023) utilizando datos de MapBiomas y límites RAISG.

## 🔗 Resultados Principales

- **VPN acumulado 2001-2023:** 12,95 billones de pesos
- **Pérdida vs PIB nacional:** 0,07%
- **Pérdida vs PIB regional amazónico:** 3,8%

## 📁 Estructura de Análisis

### 📜 Scripts de Procesamiento
- `1_Preparacion_Datos_Raisg.R` - VPN acumulado y tendencias temporales
- `2_limitesraisg_economicos.R` - Análisis territorial y por ecosistemas
- `3_integracion_powerbi.R` - Preparación de datos para visualización

### 📊 Bloques Analíticos
1. **Valoración Económica Agregada** - VPN acumulado y comparativos PIB
2. **Contraste Territorial** - Impacto por departamentos (Vaupés, Guaviare, etc.)
3. **Comparativo por Ecosistemas** - Bosques vs ecosistemas acuáticos
4. **Dinámica Temporal** - Series de tiempo 2001-2023

## 🛠️ Tecnologías Utilizadas
- **R** - Procesamiento estadístico
- **Power BI** - Visualización interactiva
- **MapBiomas** - Datos de cobertura
- **RAISG** - Límites amazónicos

## 📊 Datos Fuente
MapBiomas Colombia - Colección de cambios de cobertura departamentos
MapBiomas Colombia - Límite RAISG, Región Biogeografica Amazonia
DANE - Datos económicos departamentales

📈 Resultados Destacados
Impacto Departamental
Vaupés y Guaviare: >9% del PIB departamental

Análisis comparativo de pérdidas absolutas vs relativas

Pérdida por Ecosistemas
Bosques: 58,000 ha (2022-2023)

Ecosistemas acuáticos: 192 ha (2022-2023)

