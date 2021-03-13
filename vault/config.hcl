storage "cassandra" {
  hosts            = "127.0.0.1:9042"
  consistency      = "LOCAL_QUORUM"
  protocol_version = 3
}

listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = 1
  telemetry {
    unauthenticated_metrics_access = true
  }
}

telemetry {
  prometheus_retention_time = "2h"
  disable_hostname = true
}
