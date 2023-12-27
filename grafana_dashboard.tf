resource "grafana_folder" "ops" {
  provider = grafana.cloud

  title = "ElasticSearch"
}