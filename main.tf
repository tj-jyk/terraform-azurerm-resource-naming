locals {
  # Normalize inputs
  project      = lower(replace(var.project, "/[^a-z0-9-]/", ""))
  environment  = lower(var.environment)
  
  workload = var.workload != null && var.workload != "" ? lower(replace(var.workload, "/[^a-z0-9-]/", "")) : null
  suffix   = var.suffix != null && var.suffix != "" ? lower(replace(var.suffix, "/[^a-z0-9-]/", "")) : null

  _parts_map = {
    workload     = local.workload
    project      = local.project
    environment  = local.environment
    region       = local.region
    suffix       = local.suffix
  }

  _base_parts = compact([
    for part in var.name_order : lookup(local._parts_map, part, null)
  ])

  # Standard name with dashes (e.g. myapp-prod-weu or api-myapp-prod-weu-kv)
  _base_standard = join("-", local._base_parts)

  # Name without dashes for restricted resources (e.g. storage accounts)
  _base_nodash = join("", local._base_parts)

}
