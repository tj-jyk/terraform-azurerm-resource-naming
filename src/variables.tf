variable "project" {
  description = "Project or workload name (alphanumeric, no special chars). Example: 'myapp', 'payments'"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]+$", var.project)) && length(var.project) >= 2 && length(var.project) <= 16
    error_message = "project must be 2-16 alphanumeric characters (dashes allowed). Example: 'myapp'"
  }
}

variable "environment" {
  description = "Deployment environment"
  type        = string

  validation {
    condition     = contains(["dev", "stg", "uat", "prod"], var.environment)
    error_message = "environment must be one of: dev, stg, uat, prod"
  }
}

variable "region" {
  description = "Azure region name (full name, e.g. 'westeurope') or short code (e.g. 'weu'). Will be auto-abbreviated if known."
  type        = string

  validation {
    condition     = length(var.region) >= 2
    error_message = "region must be at least 2 characters"
  }
}

variable "workload" {
  description = "Optional workload name, inserted after resource type prefix. Example: 'api', 'worker', 'frontend'"
  type        = string
  default     = null

  validation {
    condition     = var.workload == null || (can(regex("^[a-zA-Z0-9-]+$", var.workload)) && length(var.workload) >= 1 && length(var.workload) <= 16)
    error_message = "workload must be 1-16 alphanumeric characters (dashes allowed)"
  }
}

variable "suffix" {
  description = "Optional suffix appended at the end of the name. Useful for disambiguating resources by purpose. Example: 'kv', 'evh', 'read'"
  type        = string
  default     = null

  validation {
    condition     = var.suffix == null || (can(regex("^[a-zA-Z0-9-]+$", var.suffix)) && length(var.suffix) >= 1 && length(var.suffix) <= 16)
    error_message = "suffix must be 1-16 alphanumeric characters (dashes allowed)"
  }
}

variable "name_order" {
  description = "Order of name parts. Allows overriding the default convention."
  type        = list(string)
  default     = ["workload", "project", "environment", "region"]

  validation {
    condition = alltrue([
      for part in var.name_order :
      contains(["workload", "project", "environment", "region", "suffix"], part)
    ])
    error_message = "Valid parts: workload, project, environment, region, suffix"
  }
}