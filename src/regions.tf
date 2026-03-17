locals {
  
  region       = lower(lookup(local.region_abbreviations, var.region, var.region))
  
  # ─── Region abbreviations ─────────────────────────────────────────────────────
  #Region abbreviations (Azure regions → short codes)
  # Source: https://learn.microsoft.com/en-us/azure/reliability/regions-list
  # Last updated: March 2026. Only public cloud regions included.
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
    "indonesiacentral"   = "idc"
    "japaneast"          = "jpe"
    "japanwest"          = "jpw"
    "koreacentral"       = "krc"
    "koreasouth"         = "krs"
    "malaysiawest"       = "myw"
    "newzealandnorth"    = "nzn"
    "southindia"         = "ins"
    "southeastasia"      = "sea"
    "westindia"          = "inw"

    # Canada
    "canadacentral"      = "cac"
    "canadaeast"         = "cae"

    # Europe
    "austriaeast"        = "ate"
    "belgiumcentral"     = "bec"
    "denmarkeast"        = "dke"
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
    "chilecentral"       = "clc"

    # US
    "centralus"          = "cus"
    "eastus"             = "eus"
    "eastus2"            = "eus2"
    "northcentralus"     = "ncus"
    "southcentralus"     = "scus"
    "westcentralus"      = "wcus"
    "westus"             = "wus"
    "westus2"            = "wus2"
    "westus3"            = "wus3"
  }
}