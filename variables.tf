variable "mysql_80_met" {
    type = object({
        is_present = number
        project = string
        tier = string
        region = string
        backup_configuration = list(object({
            enabled = bool
            start_time = string
            location = string
            binary_log_enabled = bool
            backup_retention_settings = list(object({
                retained_backups = number
                retention_unit = string
            }))
        }))
    })
}