locals {
  
  region       = lower(lookup(local.region_abbreviations, var.region, var.region))
  
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
}