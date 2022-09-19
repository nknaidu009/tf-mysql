mysql_80_met = {
    is_present = 1
    project = "decoded-path-356013"
    tier = "db-f1-micro"
    region = "us-central1"
    backup_configuration = [{
        enabled = true
        start_time = "20:00"
        location = "us-central1"
        binary_log_enabled = true
        backup_retention_settings = [{
            retained_backups = "7"
            retention_unit = "COUNT"
        }]
    }]
}