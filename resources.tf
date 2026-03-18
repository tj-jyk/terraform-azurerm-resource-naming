locals {
  names = {
    #https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations
    # ─── General ─────────────────────────────────────────────────────────────────
    resource_group = "rg-${local._base_standard}"

    # ─── AI + Machine Learning ───────────────────────────────────────────────────
    ai_search                  = "srch-${local._base_standard}"
    ai_foundry_tools           = "ais-${local._base_standard}"
    ai_foundry_account         = "aif-${local._base_standard}"
    ai_foundry_hub             = "hub-${local._base_standard}"
    ai_video_indexer           = "avi-${local._base_standard}"
    machine_learning_workspace = "mlw-${local._base_standard}"
    openai_account             = "oai-${local._base_standard}"
    bot_service                = "bot-${local._base_standard}"
    computer_vision            = "cv-${local._base_standard}"
    content_safety             = "cs-${local._base_standard}"
    custom_vision_prediction   = "cstv-${local._base_standard}"
    custom_vision_training     = "cstvt-${local._base_standard}"
    document_intelligence      = "di-${local._base_standard}"
    language_service           = "lang-${local._base_standard}"
    speech_service             = "spch-${local._base_standard}"
    translator                 = "trsl-${local._base_standard}"

    # ─── Analytics and IoT ───────────────────────────────────────────────────────
    analysis_services          = "as-${local._base_standard}"
    databricks_workspace       = "dbw-${local._base_standard}"
    databricks_access_connector = "dbac-${local._base_standard}"
    data_explorer_cluster      = "dec-${local._base_standard}"
    data_explorer_database     = "dedb-${local._base_standard}"
    data_factory               = "adf-${local._base_standard}"
    digital_twin               = "dt-${local._base_standard}"
    stream_analytics           = "asa-${local._base_standard}"
    synapse_workspace          = "synw-${local._base_standard}"
    synapse_sql_pool           = "syndp-${local._base_standard}"
    synapse_spark_pool         = "synsp-${local._base_standard}"
    synapse_private_link_hub   = "synplh-${local._base_standard}"
    data_lake_store            = "dls-${local._base_standard}"
    eventhub_namespace         = "evhns-${local._base_standard}"
    eventhub                   = "evh-${local._base_standard}"
    eventgrid_domain           = "evgd-${local._base_standard}"
    eventgrid_namespace        = "evgns-${local._base_standard}"
    eventgrid_topic            = "evgt-${local._base_standard}"
    eventgrid_system_topic     = "egst-${local._base_standard}"
    iot_hub                    = "iot-${local._base_standard}"
    fabric_capacity            = "fc-${local._base_standard}"
    power_bi_embedded          = "pbi-${local._base_standard}"
    time_series_insights       = "tsi-${local._base_standard}"

    # ─── Compute and Web ─────────────────────────────────────────────────────────
    app_service_environment    = "ase-${local._base_standard}"
    app_service_plan           = "asp-${local._base_standard}"
    app_service                = "app-${local._base_standard}"
    availability_set           = "avail-${local._base_standard}"
    batch_account              = "ba-${local._base_standard}"
    disk_encryption_set        = "des-${local._base_standard}"
    function_app               = "func-${local._base_standard}"
    image_gallery              = "gal-${local._base_standard}"
    image_template             = "it-${local._base_standard}"
    managed_disk               = "disk-${local._base_standard}"
    managed_disk_os            = "osdisk-${local._base_standard}"
    notification_hub           = "ntf-${local._base_standard}"
    notification_hub_namespace = "ntfns-${local._base_standard}"
    proximity_placement_group  = "ppg-${local._base_standard}"
    snapshot                   = "snap-${local._base_standard}"
    static_web_app             = "stapp-${local._base_standard}"
    virtual_machine            = "vm-${local._base_standard}"
    virtual_machine_scale_set  = "vmss-${local._base_standard}"
    # storage account for VM — no dashes, max 24 chars
    vm_storage_account         = substr(replace("stvm${local._base_nodash}", "/[^a-z0-9]/", ""), 0, 24)

    # ─── Containers ──────────────────────────────────────────────────────────────
    kubernetes_cluster         = "aks-${local._base_standard}"
    aks_node_pool_system       = "npsystem-${local._base_standard}"
    aks_node_pool_user         = "np-${local._base_standard}"
    container_app              = "ca-${local._base_standard}"
    container_app_environment  = "cae-${local._base_standard}"
    container_app_job          = "caj-${local._base_standard}"
    # no dashes, max 50 chars
    container_registry         = substr(replace("cr${local._base_nodash}", "/[^a-z0-9]/", ""), 0, 50)
    container_group            = "ci-${local._base_standard}"
    service_fabric_cluster     = "sf-${local._base_standard}"
    service_fabric_managed     = "sfmc-${local._base_standard}"

    # ─── Databases ───────────────────────────────────────────────────────────────
    cosmosdb_account           = "cosmos-${local._base_standard}"
    cosmosdb_cassandra         = "coscas-${local._base_standard}"
    cosmosdb_mongo             = "cosmon-${local._base_standard}"
    cosmosdb_nosql             = "cosno-${local._base_standard}"
    cosmosdb_table             = "costab-${local._base_standard}"
    cosmosdb_gremlin           = "cosgrm-${local._base_standard}"
    cosmosdb_postgresql        = "cospos-${local._base_standard}"
    redis_cache                = "redis-${local._base_standard}"
    sql_server                 = "sql-${local._base_standard}"
    sql_database               = "sqldb-${local._base_standard}"
    sql_elastic_pool           = "sqlep-${local._base_standard}"
    sql_managed_instance       = "sqlmi-${local._base_standard}"
    mysql_server               = "mysql-${local._base_standard}"
    postgresql_server          = "psql-${local._base_standard}"
    postgresql_flexible_server = "psqlf-${local._base_standard}"

    # ─── Developer Tools ─────────────────────────────────────────────────────────
    app_configuration          = "appcs-${local._base_standard}"
    maps_account               = "map-${local._base_standard}"
    signalr                    = "sigr-${local._base_standard}"
    web_pubsub                 = "wps-${local._base_standard}"

    # ─── DevOps ──────────────────────────────────────────────────────────────────
    managed_grafana            = "amg-${local._base_standard}"
    managed_devops_pool        = "mdp-${local._base_standard}"

    # ─── Integration ─────────────────────────────────────────────────────────────
    api_management             = "apim-${local._base_standard}"
    integration_account        = "ia-${local._base_standard}"
    logic_app                  = "logic-${local._base_standard}"
    servicebus_namespace       = "sbns-${local._base_standard}"
    servicebus_queue           = "sbq-${local._base_standard}"
    servicebus_topic           = "sbt-${local._base_standard}"
    servicebus_subscription    = "sbts-${local._base_standard}"

    # ─── Management and Governance ───────────────────────────────────────────────
    automation_account         = "aa-${local._base_standard}"
    application_insights       = "appi-${local._base_standard}"
    monitor_action_group       = "ag-${local._base_standard}"
    monitor_data_collection_rule = "dcr-${local._base_standard}"
    monitor_data_collection_endpoint = "dce-${local._base_standard}"
    monitor_alert_processing_rule = "apr-${local._base_standard}"
    log_analytics_workspace    = "log-${local._base_standard}"
    log_analytics_query_pack   = "pack-${local._base_standard}"
    management_group           = "mg-${local._base_standard}"
    purview_account            = "pview-${local._base_standard}"

    # ─── Migration ───────────────────────────────────────────────────────────────
    migrate_project            = "migr-${local._base_standard}"
    database_migration_service = "dms-${local._base_standard}"
    recovery_services_vault    = "rsv-${local._base_standard}"

    # ─── Networking ──────────────────────────────────────────────────────────────
    application_gateway        = "agw-${local._base_standard}"
    application_security_group = "asg-${local._base_standard}"
    cdn_profile                = "cdnp-${local._base_standard}"
    cdn_endpoint               = "cdne-${local._base_standard}"
    dns_forwarding_ruleset     = "dnsfrs-${local._base_standard}"
    dns_private_resolver       = "dnspr-${local._base_standard}"
    expressroute_circuit       = "erc-${local._base_standard}"
    expressroute_gateway       = "ergw-${local._base_standard}"
    frontdoor_profile          = "afd-${local._base_standard}"
    frontdoor_endpoint         = "fde-${local._base_standard}"
    frontdoor_firewall_policy  = "fdfp-${local._base_standard}"
    firewall                   = "afw-${local._base_standard}"
    firewall_policy            = "afwp-${local._base_standard}"
    load_balancer_internal     = "lbi-${local._base_standard}"
    load_balancer_external     = "lbe-${local._base_standard}"
    local_network_gateway      = "lgw-${local._base_standard}"
    nat_gateway                = "ng-${local._base_standard}"
    network_interface          = "nic-${local._base_standard}"
    network_security_group     = "nsg-${local._base_standard}"
    network_watcher            = "nw-${local._base_standard}"
    private_endpoint           = "pep-${local._base_standard}"
    private_link_service       = "pl-${local._base_standard}"
    public_ip                  = "pip-${local._base_standard}"
    public_ip_prefix           = "ippre-${local._base_standard}"
    route_table                = "rt-${local._base_standard}"
    subnet                     = "snet-${local._base_standard}"
    traffic_manager            = "traf-${local._base_standard}"
    virtual_network            = "vnet-${local._base_standard}"
    virtual_network_gateway    = "vgw-${local._base_standard}"
    virtual_network_peering    = "peer-${local._base_standard}"
    virtual_wan                = "vwan-${local._base_standard}"
    virtual_wan_hub            = "vhub-${local._base_standard}"
    vpn_gateway                = "vpng-${local._base_standard}"

    # ─── Security ────────────────────────────────────────────────────────────────
    bastion_host               = "bas-${local._base_standard}"
    key_vault                  = "kv-${local._base_standard}"
    key_vault_hsm              = "kvmhsm-${local._base_standard}"
    user_assigned_identity     = "id-${local._base_standard}"
    ssh_key                    = "sshkey-${local._base_standard}"
    waf_policy                 = "waf-${local._base_standard}"

    # ─── Storage ─────────────────────────────────────────────────────────────────
    # no dashes, max 24 chars, lowercase alphanumeric only
    storage_account            = substr(replace("st${local._base_nodash}", "/[^a-z0-9]/", ""), 0, 24)
    storage_file_share         = "share-${local._base_standard}"
    backup_vault               = "bvault-${local._base_standard}"
    storage_sync               = "sss-${local._base_standard}"

    # ─── Virtual Desktop Infrastructure ──────────────────────────────────────────
    vdi_host_pool              = "vdpool-${local._base_standard}"
    vdi_application_group      = "vdag-${local._base_standard}"
    vdi_workspace              = "vdws-${local._base_standard}"
    vdi_scaling_plan           = "vdscaling-${local._base_standard}"
  }
}
