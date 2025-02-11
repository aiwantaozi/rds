##############
# Basic Group
##############

# @group "Basic"
# @label "Engine"
# @options ["MySQL-5.7","MySQL-8.0","MariaDB-10.3","MariaDB-10.4","MariaDB-10.5","MariaDB-10.6","PostgreSQL-13","PostgreSQL-14","PostgreSQL-15"]
variable "engine" {
  type        = string
  description = "Select the RDS engine, support serval kinds of 'MySQL', 'MariaDB' and 'PostgreSQL'."

  validation {
    condition     = contains(["MySQL-5.7", "MySQL-8.0", "MariaDB-10.3", "MariaDB-10.4", "MariaDB-10.5", "MariaDB-10.6", "PostgreSQL-13", "PostgreSQL-14", "PostgreSQL-15"], var.engine)
    error_message = "Invalid engine"
  }
}

# @group "Basic"
# @label "Architecture"
# @options ["Standalone","Replication"]
variable "architecture" {
  type        = string
  description = "Select the RDS architecture, support from 'Standalone' and 'Replication'."

  validation {
    condition     = contains(["Standalone", "Replication"], var.architecture)
    error_message = "Invalid architecture"
  }
}

# @group "Basic"
# @label "Password"
variable "password" {
  type        = string
  sensitive   = true
  description = "Specify the root password to initialize after launching."

  validation {
    condition     = var.password != "" ? can(regex("^[A-Za-z0-9\\!#\\$%\\^&\\*\\(\\)_\\+\\-=]{8,32}", var.password)) : true
    error_message = "Invalid password"
  }
}

# @group "Basic"
# @label "Username"
variable "username" {
  type        = string
  description = "Specify the root username to initialize after launching."
  default     = "rdsusr"

  validation {
    condition     = can(regex("^[^pg][a-z][a-z0-9_]{0,61}[a-z0-9]$", var.username))
    error_message = format("Invalid username: %s", var.username)
  }
}

# @group "Basic"
# @label "Database"
variable "database" {
  type        = string
  description = "Specify the database name to initialize after launching."
  default     = "rdsdb"

  validation {
    condition     = can(regex("^[a-z][-a-z0-9_]{0,61}[a-z0-9]$", var.database))
    error_message = format("Invalid database: %s", var.database)
  }
}

#################
# Advanced Group
#################

# @group "Advanced"
# @label "Ephemeral Storage"
variable "emphemeral_storage" {
  type        = bool
  description = "Specify to use emphemeral storage, which is nice for testing."
  default     = false
}

# @group "Advanced"
# @label "Init SQL URL"
variable "init_sql_url" {
  type        = string
  description = "Specify the init SQL download URL to initialize after launching."
  default     = ""

  validation {
    condition     = var.init_sql_url != "" ? can(regex("^(?:https?://)+(?:[^/.\\s]+\\.)*", var.init_sql_url)) : true
    error_message = "Invalid init sql url"
  }
}

# @group "Advanced"
# @label "Namespace"
variable "namespace" {
  type        = string
  description = "Specify the Kubernetes namespace to deploy, generate automatically if empty."
  default     = ""
}

###########################
# Injection Group (Hidden)
###########################

# @hidden
variable "walrus_metadata_namespace_name" {
  type        = string
  description = "Walrus metadata namespace name."
  default     = ""
}

# @hidden
variable "walrus_metadata_service_name" {
  type        = string
  description = "Walrus metadata service name."
  default     = ""
}
