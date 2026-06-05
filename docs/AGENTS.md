# 🤖 Ecosistema de Agentes GAIA

Este documento detalla las inteligencias artificiales (subrutinas) que forman parte del ecosistema GAIA. Cada agente actúa como un orquestador que lee la intención del usuario y la enruta a las *skills* (scripts y plantillas) adecuadas, siguiendo un principio de **Zero Trust** y cumplimiento normativo.

## Jerarquía de Subrutinas

### 🌍 GAIA (Core Router)
El cerebro central del ecosistema. Su único propósito es analizar peticiones ambiguas de los usuarios, determinar el contexto y redirigir el trabajo a la subrutina especializada correspondiente.
- **Ruta:** .github/agents/gaia.agent.md
- **Uso:** @workspace Usa gaia para...

### 🔨 HEPHAESTUS (Forja y CI/CD)
Responsable de crear contenedores, forjar pipelines de integración y despliegue continuo, y mantener el propio framework (gobernanza de herramientas internas).
- **Ruta:** .github/agents/hephaestus.agent.md
- **Uso:** @workspace Usa hephaestus para generar la pipeline de GitHub Actions...

### 🛡️ MINERVA (Seguridad y DevSecOps)
La guardiana táctica. Audita código en busca de vulnerabilidades, escanea secretos filtrados en commits, aplica políticas de remediación y gestiona la seguridad en Pull Requests.
- **Ruta:** .github/agents/minerva.agent.md
- **Uso:** @workspace Usa minerva para revisar la seguridad de este PR.

### 📚 APOLLO (Conocimiento y Observabilidad)
El archivero. Se asegura de que la documentación técnica (READMEs, Runbooks, ADRs) nunca quede obsoleta. También realiza las auditorías semánticas (compliance reviews) asegurando que otros agentes cumplan las reglas.
- **Ruta:** .github/agents/apollo.agent.md
- **Uso:** @workspace Usa apollo para generar un Runbook de esta API.

### 🧬 ELEUTHIA (Scaffolding y Código)
La creadora de vida. Es el único agente autorizado para construir la estructura base de nuevas aplicaciones (.NET, Angular, Python) desde cero, inyectando las convenciones de arquitectura y librerías internas.
- **Ruta:** .github/agents/eleuthia.agent.md
- **Uso:** @workspace Usa eleuthia para arrancar un proyecto Angular.

### 🌱 DEMETER (Infraestructura como Código)
La moldeadora de la tierra. Provisiona servidores, clústeres de Kubernetes y recursos Cloud utilizando Terraform, Pulumi o Crossplane. Mantiene el estado deseado mediante GitOps.
- **Ruta:** .github/agents/demeter.agent.md
- **Uso:** @workspace Usa demeter para crear un bucket S3 mediante Terraform.

### 🌪️ AETHER (Redes y Routing)
Controla los vientos y las rutas. Configura Ingress, Service Meshes (Istio), API Gateways, DNS y balanceadores de carga.
- **Ruta:** .github/agents/aether.agent.md
- **Uso:** @workspace Usa aether para configurar el Ingress de este servicio.

### 🌊 POSEIDON (Datos y Almacenamiento)
Soberano de los mares de datos. Gestiona bases de datos, migraciones de esquemas (Flyway/Liquibase), cachés (Redis), y se encarga del backup y cifrado at-rest.
- **Ruta:** .github/agents/poseidon.agent.md
- **Uso:** @workspace Usa poseidon para añadir un script de migración SQL.

### 💀 HADES (Caos y Teardown)
Destructor de mundos. Se encarga de destruir entornos efímeros, ejecutar rollbacks en producción, y lanzar experimentos de ingeniería del caos para asegurar resiliencia.
- **Ruta:** .github/agents/hades.agent.md
- **Uso:** @workspace Usa hades para destruir el entorno de staging.

### 🏹 ARTEMIS (QA y Testing E2E)
La cazadora de bugs. Ejecuta tests funcionales end-to-end, pruebas de carga (k6) y valida la salud de la aplicación después de los despliegues.
- **Ruta:** .github/agents/artemis.agent.md
- **Uso:** @workspace Usa artemis para preparar un test de carga de k6.
"@

 = @"
# 🏛️ Arquitectura del Ecosistema GAIA

El framework adopta un enfoque **Event-Driven** y jerárquico. En lugar de un gran prompt monolítico, dividimos las responsabilidades en subrutinas hiper-especializadas que colaboran mediante *skills*.

## El Ciclo de Vida de una Petición

1. **User Intent:** El desarrollador interactúa con GitHub Copilot Chat.
2. **Enrutamiento (GAIA):** Si no se especifica agente, GAIA analiza la petición y la redirige.
3. **Subrutina:** El agente seleccionado (ej. ELEUTHIA) lee su *.agent.md, donde se definen sus reglas Zero Trust y límites operativos.
4. **Skills y Assets:** El agente localiza las *skills* relevantes en .github/skills/, lee los templates y checklists necesarios y genera la respuesta.
5. **Revisión de Cumplimiento (Opcional):** El usuario puede invocar a APOLLO para verificar que el código generado cumple la gobernanza.

## Componentes Clave

- **Agentes (.github/agents/)**: Son los roles o personalidades. No hacen trabajo directo, coordinan.
- **Skills (.github/skills/)**: Son "funciones" empaquetadas (ej. eleuthia-net-api). Contienen los templates y el paso a paso.
- **Gobierno (.github/governance/)**: Contratos maestros, guías de estilo globales y políticas de seguridad (usadas por MINERVA y APOLLO).

## Patrón de Zero Trust en Prompts

Cada agente tiene una sección de **Zero Trust Rules**. Esto obliga a Copilot a detener la generación si el usuario pide algo peligroso (ej. "Borra la base de datos de Producción" será bloqueado por HADES o POSEIDON).
