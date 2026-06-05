# 🤖 GAIA: Autonomous Platform Engineering & Development Framework

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![GitHub Copilot](https://img.shields.io/badge/GitHub%20Copilot-Ready-8957e5?logo=github)](https://github.com/features/copilot)

> **Un ecosistema de agentes autónomos para Platform Engineering, DevOps y Scaffolding de código, inspirado en Horizon Zero Dawn.**

Convierte tu GitHub Copilot en un motor de orquestación determinista y auto-gobernado que cubre el ciclo de vida completo: desde la forja de la infraestructura hasta la observabilidad y el despliegue de aplicaciones.

---

## ✨ ¿Por qué este Framework?

El ecosistema GAIA (Global Autonomous Infrastructure Architecture) abandona los flujos monolíticos para adoptar una arquitectura de enjambre orientada a eventos (*Event-Driven*) y *Zero Trust*.

| Problema | Solución GAIA |
|---------|----------|
| Peticiones complejas sin contexto | **GAIA Core** enruta inteligentemente la intención del usuario a subrutinas especializadas. |
| Inconsistencia en la creación de proyectos | **ELEUTHIA** estandariza el scaffolding de aplicaciones (.NET, Angular, Python). |
| Infraestructura manual y frágil | **DEMETER** y **HEPHAESTUS** forjan pipelines y clústeres mediante IaC (Terraform, K8s). |
| Seguridad reactiva y monolítica | **MINERVA** aplica auditorías dinámicas y gestión de secretos con un enfoque Zero Trust. |
| Caída del conocimiento | **APOLLO** genera ADRs, Runbooks y mantiene la observabilidad viva. |

---

## 🏗️ Arquitectura

`mermaid
graph TB
    subgraph "Entry Layer"
        U[User Request] --> G[GAIA Core Router]
        U --> D[Direct Subroutine Call]
    end

    subgraph "Subrutinas (Agentes Autónomos)"
        G --> HEPH[HEPHAESTUS]
        G --> MIN[MINERVA]
        G --> ELEU[ELEUTHIA]
        G --> APO[APOLLO]
        G --> DEM[DEMETER]
        G --> AET[AETHER]
        G --> HAD[HADES]
        G --> POS[POSEIDON]
        G --> ART[ARTEMIS]
    end

    subgraph "Skills y Governance"
        HEPH --> CI[Pipelines & CI/CD]
        MIN --> SEC[SecOps & IAM]
        ELEU --> SCAF[Scaffolding & Code Generation]
        APO --> DOC[Docs & Observability]
        DEM --> IAC[Terraform & GitOps]
        AET --> NET[Service Mesh & DNS]
        HAD --> ROL[Rollbacks & Chaos]
        POS --> DAT[DBs & Storage]
        ART --> QA[Load Testing & E2E]
    end

    style U fill:#4CAF50,color:#fff
    style G fill:#FF9800,color:#fff
    style HEPH fill:#2196F3,color:#fff
    style MIN fill:#E91E63,color:#fff
    style ELEU fill:#9C27B0,color:#fff
    style APO fill:#03A9F4,color:#fff
    style DEM fill:#4CAF50,color:#fff
    style AET fill:#00BCD4,color:#fff
    style HAD fill:#F44336,color:#fff
    style POS fill:#3F51B5,color:#fff
    style ART fill:#8BC34A,color:#fff
`

## 📋 Catálogo de Subrutinas

| Subrutina | Rol en el Ecosistema | Propósito y Capacidades |
|-----------|-----------------------|-------------------------|
| 🌍 **GAIA** | Orquestador Core | Enruta peticiones de usuario a la subrutina adecuada basándose en el estado. |
| 🔨 **HEPHAESTUS**| Forja y CI/CD | Construcción de contenedores, pipelines, registries y creación del propio framework. |
| 🛡️ **MINERVA** | DevSecOps y Zero Trust| Escaneo de vulnerabilidades, auditoría, remediación automática, gestión de secretos. |
| 📚 **APOLLO** | Conocimiento y Observabilidad | Runbooks vivos, ADRs, configuración de dashboards, revisión de cumplimiento. |
| 🧬 **ELEUTHIA** | Scaffolding de Código | Andamiaje de aplicaciones desde cero (.NET, Angular, Python). |
| 🌱 **DEMETER** | IaC y Provisioning | Despliegue de infraestructura base con Terraform/Pulumi, sincronización GitOps. |
| 🌪️ **AETHER** | Redes | Service Mesh (Istio), API Gateways, Ingress Controllers, DNS, WAF. |
| 💀 **HADES** | Caos y Destrucción | Teardown de entornos efímeros, simulaciones de desastres, rollbacks automáticos. |
| 🌊 **POSEIDON** | Datos y Almacenamiento | Gestión de volúmenes persistentes, migraciones de esquemas de bases de datos, backups. |
| 🏹 **ARTEMIS** | Quality Assurance (QA) | Caza de bugs, integración continua de tests E2E, pruebas de carga. |

> 📖 **Documentación Completa:** [docs/AGENTS.md](docs/AGENTS.md)

---

## 🚀 Quick Start

### 1. Clonar el repositorio

`ash
git clone https://github.com/l3onkers/copilot-governance-framework.git
cd copilot-governance-framework
`

### 2. Abrir en VS Code con GitHub Copilot

El ecosistema GAIA opera a través de GitHub Copilot Chat. Abre el repositorio en VS Code y asegúrate de tener Copilot activo.

### 3. Contactar con GAIA

¿No sabes qué subrutina usar? Pregunta a GAIA:

@workspace Usa gaia para preparar la infraestructura y el código de un nuevo microservicio con base de datos.

GAIA enrutará la petición automáticamente a **ELEUTHIA** para generar el código, a **HEPHAESTUS** para los pipelines, y a **POSEIDON** para la base de datos.

### 4. Invocación Directa

Si conoces la subrutina exacta:

@workspace Usa minerva para ejecutar una revisión de seguridad y un escaneo de secretos sobre los últimos commits.

> 📖 **Guía Detallada:** [QUICKSTART.md](QUICKSTART.md)

---

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Revisa [CONTRIBUTING.md](CONTRIBUTING.md) antes de enviar un pull request.

## 📄 Licencia

Este proyecto está bajo la Licencia MIT — ver [LICENSE](LICENSE) para más detalles.

## 👤 Autor

Creado y mantenido por **[l3onkers](https://github.com/l3onkers)**.
Evolucionado hacia la arquitectura GAIA.
