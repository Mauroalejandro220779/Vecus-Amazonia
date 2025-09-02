# VECUS - Amazonia

# 📊 VECUS: Valoración Económica de Coberturas y Usos del Suelo

[![Socrates Data](https://github.com/user-attachments/assets/06393ce0-b276-4e85-8aca-bdb73f99d4ec)](https://socratesdata.org/)
[![Power BI Dashboard](https://img.shields.io/badge/📊_Dashboard_Interactivo-Acceder_ahora-red?style=for-the-badge)](https://app.powerbi.com/view?r=eyJrIjoiNjUyNGY1ZjgtMWYyNy00ZDRhLWE1MDEtMjhiZWUyOTk5MTJhIiwidCI6ImZiZThmYzg4LWZhODctNGM2Ni1iMTBjLWJmYTBjN2YyMjlhOSIsImMiOjR9&pageName=0374a3990e6a754ac6c3)

**Herramienta modular para estimación de pérdida económica por deforestación en la Amazonia Colombiana a partir de datos de MapBiomas**

*Proyecto desarrollado en colaboración con [Socrates Data](https://socratesdata.org/)*

---

Análisis integral del impacto económico de la deforestación en la Amazonia colombiana (2001-2023) utilizando datos de MapBiomas y límites RAISG.

## 🔗 Resultados Principales

- **VPN acumulado 2001-2023:** 12,95 billones de pesos
- **Pérdida vs PIB nacional:** 0,07%
- **Pérdida vs PIB regional amazónico:** 3,8%

## 📁 Estructura de Análisis

### 📜 Scripts de Procesamiento
- `1_Preparacion_Datos_Raisg.R` - VPN acumulado y tendencias temporales. 
- `2_limitesraisg_economicos.R` - Análisis territorial y por ecosistemas
-  Ambos scripts incluyen preparación de datos para visualización en Power BI

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

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Para cambios importantes:

1. **Fork** el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/NuevaFeature`)
3. Commit tus cambios (`git commit -m 'Add NuevaFeature'`)
4. Push a la rama (`git push origin feature/NuevaFeature`)
5. Abre un **Pull Request**

## 📝 Licencia

Este proyecto está bajo la **Licencia MIT**. Ver el archivo [`LICENSE`](LICENSE) para más detalles.

## 👥 Autor

- **Mauro A. Reyes Bonilla** - [GitHub](https://github.com/Mauroalejandro220779)
- **Contacto:** mauro.reyes@socrates.org

## 🔄 Actualización

Para actualizar los análisis:

1. Modificar los scripts en la carpeta `scripts/`
2. Ejecutar en orden:
   ```r
   source("scripts/1_Preparacion_Datos_Raisg.R")
   source("scripts/2_limitesraisg_economicos.R")

## 📚 Citar este Trabajo

```bibtex
@software{Reyes_2024_Amazonia_Deforestacion,
  author = {Reyes Bonilla, Mauro A.},
  title = {Valoración Económica de la Deforestación en la Amazonia Colombiana},
  year = {2024},
  publisher = {Socrates Data},
  url = {https://github.com/Mauroalejandro220779/amazonia-deforestacion-economic-impact}
}

