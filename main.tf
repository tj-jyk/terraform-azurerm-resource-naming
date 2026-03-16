locals {
  # Normalize inputs
  project      = lower(replace(var.project, "/[^a-z0-9-]/", ""))
  environment  = lower(var.environment)
  region       = lower(lookup(local.region_abbreviations, var.region, var.region))
  workload = var.workload != null ? lower(replace(var.workload, "/[^a-z0-9-]/", "")) : null
  suffix       = var.suffix != null ? lower(replace(var.suffix, "/[^a-z0-9-]/", "")) : null

  #Region abbreviations (Azure regions → short codes)
  # Source: https://gist.github.com/ausfestivus/04e55c7d80229069bf3bc75870630ec8
  region_abbreviations = {
    # Africa
    "southafricanorth"   = "san"
    "southafricawest"    = "saw"

    # Asia Pacific
    "australiacentral"   = "auc"
    "australiacentral2"  = "auc2"
    "australiaeast"      = "aue"
    "australiasoutheast" = "ause"
    "centralindia"       = "inc"
    "eastasia"           = "eas"
    "japaneast"          = "jpe"
    "japanwest"          = "jpw"
    "jioindiacentral"    = "jiic"
    "jioindiawest"       = "jiiw"
    "koreacentral"       = "krc"
    "koreasouth"         = "krs"
    "southindia"         = "ins"
    "southeastasia"      = "sea"
    "westindia"          = "inw"

    # Canada
    "canadacentral"      = "cac"
    "canadaeast"         = "cae"

    # Europe
    "francecentral"      = "frc"
    "francesouth"        = "frs"
    "germanynorth"       = "gern"
    "germanywestcentral" = "gwc"
    "italynorth"         = "itn"
    "northeurope"        = "neu"
    "norwayeast"         = "noe"
    "norwaywest"         = "now"
    "polandcentral"      = "plc"
    "spaincentral"       = "esc"
    "swedencentral"      = "swc"
    "switzerlandnorth"   = "chn"
    "switzerlandwest"    = "chw"
    "uksouth"            = "uks"
    "ukwest"             = "ukw"
    "westeurope"         = "weu"

    # Mexico
    "mexicocentral"      = "mxc"

    # Middle East
    "israelcentral"      = "ilc"
    "qatarcentral"       = "qac"
    "uaecentral"         = "uaec"
    "uaenorth"           = "uaen"

    # South America
    "brazilsouth"        = "brs"
    "brazilsoutheast"    = "brse"
    "brazilus"           = "brus"

    # US
    "centralus"          = "cus"
    "centraluseuap"      = "cuseuap"
    "eastus"             = "eus"
    "eastus2"            = "eus2"
    "eastus2euap"        = "eus2euap"
    "eastusstg"          = "eusstg"
    "northcentralus"     = "ncus"
    "southcentralus"     = "scus"
    "southcentralusstg"  = "scusstg"
    "westcentralus"      = "wcus"
    "westus"             = "wus"
    "westus2"            = "wus2"
    "westus3"            = "wus3"
  }


  # Base name parts (without type prefix)
  # Order: [service_name]-{project}-{env}-{region}-[instance]-[suffix]
  _base_parts = compact([
    local.workload,
    local.project,
    local.environment,
    local.region,
    local.suffix,
  ])

  # Standard name with dashes (e.g. myapp-prod-weu or api-myapp-prod-weu-kv)
  _base_standard = join("-", local._base_parts)

  # Name without dashes for restricted resources (e.g. storage accounts)
  _base_nodash = join("", local._base_parts)

  #
  # ─── RESOURCE NAMES ────────────────────────────────────────────────────────────
  #

  names = {
    # Resource Group
    resource_group = "rg-${local._base_standard}"

    # Networking
    virtual_network              = "vnet-${local._base_standard}"
    subnet                       = "snet-${local._base_standard}"
    network_security_group       = "nsg-${local._base_standard}"
    public_ip                    = "pip-${local._base_standard}"
    load_balancer                = "lb-${local._base_standard}"
    application_gateway          = "agw-${local._base_standard}"
    private_endpoint             = "pep-${local._base_standard}"
    private_dns_zone             = "pdns-${local._base_standard}"
    nat_gateway                  = "ng-${local._base_standard}"
    bastion_host                 = "bas-${local._base_standard}"
    vpn_gateway                  = "vpng-${local._base_standard}"
    route_table                  = "rt-${local._base_standard}"
    firewall                     = "afw-${local._base_standard}"
    firewall_policy              = "afwp-${local._base_standard}"
    ddos_protection_plan         = "ddos-${local._base_standard}"

    # Compute
    virtual_machine              = "vm-${local._base_standard}"
    virtual_machine_scale_set    = "vmss-${local._base_standard}"
    availability_set             = "avail-${local._base_standard}"
    managed_disk                 = "disk-${local._base_standard}"

    # Containers
    container_registry           = substr(replace("cr${local._base_nodash}", "/[^a-z0-9]/", ""), 0, 50)
    kubernetes_cluster           = "aks-${local._base_standard}"
    container_group              = "ci-${local._base_standard}"

    # App Services
    app_service_plan             = "asp-${local._base_standard}"
    app_service                  = "app-${local._base_standard}"
    function_app                 = "func-${local._base_standard}"
    static_web_app               = "stapp-${local._base_standard}"
    api_management               = "apim-${local._base_standard}"

    # Storage — no dashes, max 24 chars, lowercase alphanumeric only
    storage_account              = substr(replace("st${local._base_nodash}", "/[^a-z0-9]/", ""), 0, 24)
    storage_container            = "sc-${local._base_standard}"

    # Databases
    sql_server                   = "sql-${local._base_standard}"
    sql_database                 = "sqldb-${local._base_standard}"
    postgresql_server            = "psql-${local._base_standard}"
    postgresql_flexible_server   = "psqlf-${local._base_standard}"
    mysql_server                 = "mysql-${local._base_standard}"
    cosmosdb_account             = "cosmos-${local._base_standard}"
    redis_cache                  = "redis-${local._base_standard}"

    # Integration & Messaging
    servicebus_namespace         = "sb-${local._base_standard}"
    servicebus_queue             = "sbq-${local._base_standard}"
    servicebus_topic             = "sbt-${local._base_standard}"
    eventhub_namespace           = "evhns-${local._base_standard}"
    eventhub                     = "evh-${local._base_standard}"
    eventgrid_topic              = "evgt-${local._base_standard}"

    # Security & Identity
    key_vault                    = "kv-${local._base_standard}"
    user_assigned_identity       = "id-${local._base_standard}"

    # Monitoring & Governance
    log_analytics_workspace      = "log-${local._base_standard}"
    application_insights         = "appi-${local._base_standard}"
    monitor_action_group         = "ag-${local._base_standard}"
    policy_assignment            = "pa-${local._base_standard}"

    # AI & ML
    machine_learning_workspace   = "mlw-${local._base_standard}"
    cognitive_account            = "cog-${local._base_standard}"
    openai_account               = "oai-${local._base_standard}"

    # Data
    synapse_workspace            = "syn-${local._base_standard}"
    data_factory                 = "adf-${local._base_standard}"
    databricks_workspace         = "dbw-${local._base_standard}"
  }
}
