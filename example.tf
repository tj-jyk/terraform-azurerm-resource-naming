# module "naming" {

#   project     = "payments"
#   environment = "prod"
#   region      = "westeurope"
#   suffix      = "platformteam"  
#   name_order  = ["suffix", "project", "environment", "region"]
# }

# module "namingV2" {

#   project     = "payments"
#   environment = "prod"
#   region      = "westeurope"
#   name_order  = ["project", "environment", "region"]
# }


# module "namingV2" {

#   workload    = "auth"
#   project     = "payments"
#   environment = "prod"
#   region      = "westeurope"
#   name_order  = ["workload", "project", "environment", "region"]
# }
# # rg-prod-platformteam-payments-weu