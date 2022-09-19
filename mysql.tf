data "google_compute_network" "default" {
    name = "default"
}

resource "google_sql_database_instance" "mysql_80" {
    count = var.mysql_80_met.is_present

    name = "dev-mysql-80"
    region = var.mysql_80_met.region
    project = var.mysql_80_met.project
    database_version = "MYSQL_8_0"
    settings {
        tier = var.mysql_80_met.tier
        disk_type = "PD_SSD"
        ip_configuration {
            ipv4_enabled = false
            private_network = data.google_compute_network.default.self_link
        }
        dynamic "backup_configuration" {
            for_each = var.mysql_80_met.backup_configuration
            content {
                binary_log_enabled = backup_configuration.value["binary_log_enabled"]
                enabled = backup_configuration.value["enabled"]
                start_time =  backup_configuration.value["start_time"]
                location =  backup_configuration.value["location"]
                dynamic "backup_retention_settings" {
                    for_each = var.mysql_80_met.backup_configuration.0.backup_retention_settings
                    content {
                        retained_backups = backup_retention_settings.value["retained_backups"]
                        retention_unit = backup_retention_settings.value["retention_unit"]
                    }
                }
            }
        }
    }
}