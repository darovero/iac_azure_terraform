# AZ-INFRA-DAROVERO

Framework Terraform modular para despliegue de infraestructura en Microsoft Azure siguiendo buenas prácticas enterprise, reutilización de módulos y separación por ambientes.

---

# Objetivos del proyecto

Este proyecto busca:

- Estandarizar despliegues en Azure.
- Permitir reutilización de módulos Terraform.
- Facilitar despliegues multiambiente.
- Centralizar configuraciones usando `terraform.tfvars`.
- Mantener una arquitectura escalable y mantenible.
- Integrarse fácilmente con Azure DevOps CI/CD.

---

# Estructura del proyecto

```text
├── environments/
│   ├── dev/
│   ├── qa/
│   └── prd/
│
├── modules/
│   ├── application_gateway/
│   ├── application_insights/
│   ├── container_registry/
│   ├── data_factory/
│   ├── elastic_pool/
│   ├── function_app/
│   ├── key_vault/
│   ├── kubernetes_cluster/
│   ├── log_analytics/
│   ├── network_security_group/
│   ├── resource_group/
│   ├── service_plan/
│   ├── sql_server/
│   ├── storage_account/
│   ├── virtual_machine/
│   ├── virtual_network/
│   └── web_app/
│
├── .gitignore
└── README.md
```

---

# Flujo recomendado de despliegue

## Inicializar Terraform

```bash
terraform init
```

## Validar formato

```bash
terraform fmt -recursive
```

## Validar sintaxis

```bash
terraform validate
```

## Generar plan

```bash
terraform plan -out=plans/dev-create.tfplan
```

## Aplicar despliegue

```bash
terraform apply plans/dev-create.tfplan
```

---

# Componentes soportados

- Resource Groups
- Log Analytics
- Application Insights
- Key Vault
- Storage Accounts
- SQL Server
- Elastic Pools
- Virtual Networks
- Network Security Groups
- Azure Container Registry
- Azure Kubernetes Service (AKS)
- Application Gateway
- Virtual Machines
- Service Plans
- Web Apps
- Function Apps
- Azure Data Factory

---

# Recomendaciones Enterprise

## Mantener nombres consistentes

Formato recomendado:

```text
<empresa><ambiente><tipo><consecutivo>
```

Ejemplo:

```text
bogdevsql001
```

## No almacenar secretos en terraform.tfvars

Usar:

- Azure Key Vault
- Azure DevOps Variable Groups
- Variables de entorno

## Uso de Remote State

Recomendado:

```text
Azure Storage Account + Blob Container
```

---

# Integración con Azure DevOps

Pipeline recomendado:

```text
Validate
→ Plan
→ Approval
→ Apply
```

Uso recomendado:

```bash
terraform plan -out=tfplan
terraform apply tfplan
```
