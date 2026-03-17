# terraform-azurerm-resource-naming

A Terraform / OpenTofu module for generating consistent, CAF-aligned Azure resource names.

All resource names follow a single configurable template:

```
{type}-[{workload}-]{project}-{env}-{region}[-{suffix}]
```

Abbreviations are sourced from the official [Microsoft CAF naming conventions](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations).  
Region codes are derived from the full [Azure region list](https://gist.github.com/ausfestivus/04e55c7d80229069bf3bc75870630ec8).

---

## Requirements

| Tool | Version |
|---|---|
| Terraform | `>= 1.3.0` |
| OpenTofu | `>= 1.6.0` |

No providers required — this is a pure locals module.

---

## Installation

```hcl
module "naming" {
  source = "github.com/tj-jyk/terraform-azurerm-resource-naming?ref=v1.0.0"

  project     = "payments"
  environment = "prod"
  region      = "westeurope"
}
```

---

## Usage

### Basic

```hcl
module "naming" {
  source = "github.com/tj-jyk/terraform-azurerm-resource-naming?ref=v1.0.0"

  project     = "payments"
  environment = "prod"
  region      = "westeurope"
}

resource "azurerm_resource_group" "main" {
  name     = module.naming.resource_group   # → rg-payments-prod-weu
  location = "westeurope"
}

resource "azurerm_key_vault" "main" {
  name = module.naming.key_vault            # → kv-payments-prod-weu
}

resource "azurerm_storage_account" "main" {
  name = module.naming.storage_account      # → stpaymentsprodweu
}
```

---

### With workload

Use `workload` to distinguish resources within the same project that belong to different components.

```hcl
module "naming" {
  source = "github.com/tj-jyk/terraform-azurerm-resource-naming?ref=v1.0.0"

  project     = "payments"
  environment = "prod"
  region      = "westeurope"
  workload    = "api"
}

# module.naming.resource_group  → rg-api-payments-prod-weu
# module.naming.key_vault       → kv-api-payments-prod-weu
# module.naming.storage_account → stapipaymentsprodweu
```

---

### With suffix — multiple resources of the same type

Use `suffix` to differentiate resources of the same type within the same project, for example multiple Managed Identities with different roles.

```hcl
module "naming_mi_kv" {
  source = "github.com/tj-jyk/terraform-azurerm-resource-naming?ref=v1.0.0"

  project     = "payments"
  environment = "prod"
  region      = "westeurope"
  suffix      = "kv"
}

module "naming_mi_evh" {
  source = "github.com/tj-jyk/terraform-azurerm-resource-naming?ref=v1.0.0"

  project     = "payments"
  environment = "prod"
  region      = "westeurope"
  suffix      = "evh"
}

# module.naming_mi_kv.user_assigned_identity  → id-payments-prod-weu-kv
# module.naming_mi_evh.user_assigned_identity → id-payments-prod-weu-evh
```

---

### Multi-region deployment

Use separate module calls per region. The region code is automatically included in every resource name, so there are no naming conflicts.

```hcl
module "naming_weu" {
  source = "github.com/tj-jyk/terraform-azurerm-resource-naming?ref=v1.0.0"

  project     = "payments"
  environment = "prod"
  region      = "westeurope"
}

module "naming_eus" {
  source = "github.com/tj-jyk/terraform-azurerm-resource-naming?ref=v1.0.0"

  project     = "payments"
  environment = "prod"
  region      = "eastus"
}

resource "azurerm_resource_group" "weu" {
  name     = module.naming_weu.resource_group  # → rg-payments-prod-weu
  location = "westeurope"
}

resource "azurerm_resource_group" "eus" {
  name     = module.naming_eus.resource_group  # → rg-payments-prod-eus
  location = "eastus"
}

resource "azurerm_key_vault" "weu" {
  name                = module.naming_weu.key_vault  # → kv-payments-prod-weu
  resource_group_name = azurerm_resource_group.weu.name
  location            = azurerm_resource_group.weu.location
}

resource "azurerm_key_vault" "eus" {
  name                = module.naming_eus.key_vault  # → kv-payments-prod-eus
  resource_group_name = azurerm_resource_group.eus.name
  location            = azurerm_resource_group.eus.location
}
```

---

### Custom name order

Use `name_order` to override the default part sequence. Useful when integrating with a legacy or company-specific naming convention. Parts not provided (i.e. `null`) are automatically omitted.

```hcl
# Default order: workload-project-env-region-suffix
# Company convention: env-workload-project-region

module "naming" {
  source = "github.com/tj-jyk/terraform-azurerm-resource-naming?ref=v1.0.0"

  project     = "payments"
  environment = "prod"
  region      = "westeurope"
  workload    = "platform"
  name_order  = ["environment", "workload", "project", "region"]
}

# module.naming.resource_group → rg-prod-platform-payments-weu
# module.naming.key_vault      → kv-prod-platform-payments-weu
```

---

### Random suffix

Generate a random suffix outside the module and pass it as `suffix`. This keeps the module side-effect free and ensures the value is stable in Terraform state.

```hcl
resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}

module "naming" {
  source = "github.com/tj-jyk/terraform-azurerm-resource-naming?ref=v1.0.0"

  project     = "payments"
  environment = "prod"
  region      = "westeurope"
  suffix      = random_string.suffix.result
}

# module.naming.storage_account → stpaymentsprodweua3k9
# module.naming.key_vault       → kv-payments-prod-weu-a3k9
```

---

## Inputs

| Name | Type | Required | Default | Description |
|---|---|---|---|---|
| `project` | `string` | ✅ | — | Project name. 2–16 chars, alphanumeric and dashes |
| `environment` | `string` | ✅ | — | Environment: `dev`, `stg`, `uat`, `prod` |
| `region` | `string` | ✅ | — | Azure region full name (e.g. `westeurope`) or short code (e.g. `weu`) |
| `workload` | `string` | ❌ | `null` | Optional component name inserted after type prefix. 1–16 chars |
| `suffix` | `string` | ❌ | `null` | Optional suffix appended at the end. 1–16 chars |
| `name_order` | `list(string)` | ❌ | `["workload","project","environment","region","suffix"]` | Order of name parts. Valid values: `workload`, `project`, `environment`, `region`, `suffix` |

---

## Outputs

### `names`

A map containing all generated resource names. Use it to access any resource type not exposed as a dedicated output:

```hcl
module.naming.names.container_app_environment  # → cae-payments-prod-weu
module.naming.names.synapse_workspace          # → synw-payments-prod-weu
module.naming.names.logic_app                  # → logic-payments-prod-weu
```

### Convenience outputs

The most commonly used resources are also exposed as top-level outputs:

| Output | Example value |
|---|---|
| `resource_group` | `rg-payments-prod-weu` |
| `region` | `weu` |
| `virtual_network` | `vnet-payments-prod-weu` |
| `subnet` | `snet-payments-prod-weu` |
| `network_security_group` | `nsg-payments-prod-weu` |
| `application_gateway` | `agw-payments-prod-weu` |
| `firewall` | `afw-payments-prod-weu` |
| `private_endpoint` | `pep-payments-prod-weu` |
| `public_ip` | `pip-payments-prod-weu` |
| `nat_gateway` | `ng-payments-prod-weu` |
| `bastion_host` | `bas-payments-prod-weu` |
| `kubernetes_cluster` | `aks-payments-prod-weu` |
| `container_registry` | `crpaymentsprodweu` |
| `container_app` | `ca-payments-prod-weu` |
| `container_app_environment` | `cae-payments-prod-weu` |
| `virtual_machine` | `vm-payments-prod-weu` |
| `virtual_machine_scale_set` | `vmss-payments-prod-weu` |
| `app_service_plan` | `asp-payments-prod-weu` |
| `app_service` | `app-payments-prod-weu` |
| `function_app` | `func-payments-prod-weu` |
| `static_web_app` | `stapp-payments-prod-weu` |
| `storage_account` | `stpaymentsprodweu` |
| `backup_vault` | `bvault-payments-prod-weu` |
| `key_vault` | `kv-payments-prod-weu` |
| `user_assigned_identity` | `id-payments-prod-weu` |
| `sql_server` | `sql-payments-prod-weu` |
| `sql_database` | `sqldb-payments-prod-weu` |
| `postgresql_flexible_server` | `psqlf-payments-prod-weu` |
| `cosmosdb_account` | `cosmos-payments-prod-weu` |
| `redis_cache` | `redis-payments-prod-weu` |
| `api_management` | `apim-payments-prod-weu` |
| `servicebus_namespace` | `sbns-payments-prod-weu` |
| `logic_app` | `logic-payments-prod-weu` |
| `eventhub_namespace` | `evhns-payments-prod-weu` |
| `eventhub` | `evh-payments-prod-weu` |
| `log_analytics_workspace` | `log-payments-prod-weu` |
| `application_insights` | `appi-payments-prod-weu` |
| `recovery_services_vault` | `rsv-payments-prod-weu` |
| `machine_learning_workspace` | `mlw-payments-prod-weu` |
| `openai_account` | `oai-payments-prod-weu` |
| `ai_search` | `srch-payments-prod-weu` |
| `data_factory` | `adf-payments-prod-weu` |
| `databricks_workspace` | `dbw-payments-prod-weu` |
| `synapse_workspace` | `synw-payments-prod-weu` |
| `app_configuration` | `appcs-payments-prod-weu` |
| `managed_grafana` | `amg-payments-prod-weu` |
| `context` | debug map with normalized inputs |

---

## Resource naming constraints

Some Azure resources have strict naming rules. The module handles these automatically:

| Resource | Constraint | How it is handled |
|---|---|---|
| Storage Account | `[a-z0-9]` only, max 24 chars | Dashes removed, truncated to 24 |
| Container Registry | `[a-z0-9]` only, max 50 chars | Dashes removed, truncated to 50 |
| VM Storage Account | `[a-z0-9]` only, max 24 chars | Prefix `stvm`, dashes removed |

---

## Region codes reference

The module auto-abbreviates known Azure regions based on the official Microsoft list.  
Source: [Azure regions list](https://learn.microsoft.com/en-us/azure/reliability/regions-list) — last updated March 2026. Only public cloud regions are included.

| Region | Code | Region | Code |
|---|---|---|---|
| `westeurope` | `weu` | `eastus` | `eus` |
| `northeurope` | `neu` | `eastus2` | `eus2` |
| `uksouth` | `uks` | `westus` | `wus` |
| `germanywestcentral` | `gwc` | `westus2` | `wus2` |
| `swedencentral` | `swc` | `centralus` | `cus` |
| `francecentral` | `frc` | `northcentralus` | `ncus` |
| `switzerlandnorth` | `chn` | `southcentralus` | `scus` |
| `norwayeast` | `noe` | `canadacentral` | `cac` |
| `australiaeast` | `aue` | `brazilsouth` | `brs` |
| `japaneast` | `jpe` | `southeastasia` | `sea` |
| `koreacentral` | `krc` | `eastasia` | `eas` |
| `uaenorth` | `uaen` | `southafricanorth` | `san` |
| `austriaeast` | `ate` | `belgiumcentral` | `bec` |
| `indonesiacentral` | `idc` | `malaysiawest` | `myw` |
| `newzealandnorth` | `nzn` | `chilecentral` | `clc` |
| `denmarkeast` | `dke` | `mexicocentral` | `mxc` |

> If a region is not in the table, the value is used as-is. Full list in `regions.tf`.

---

## Module structure

```
terraform-azurerm-resource-naming/srs
├── main.tf         # Input normalization, region map, name assembly
├── variables.tf    # Input variables with validation
├── regions.tf      # The region map
├── resources.tf    # All resource name definitions (CAF-aligned)
├── outputs.tf      # Convenience outputs + full names map
└── versions.tf     # Terraform / OpenTofu version constraints
```

---

## Contributing

Resource abbreviations follow the official Microsoft CAF table:  
https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations

When adding a new resource type, add it to `resources.tf` under the appropriate section comment and expose it in `outputs.tf` if it is commonly used.

---

## License

Apache-2.0 license 