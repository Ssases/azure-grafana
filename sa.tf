resource "terraform_data" "grafana-sa" {
  triggers_replace = timestamp()

  provisioner "local-exec" {
    command = <<EOF
    az grafana service-account create -g My-app -n grafana-testing --service-account myAccount --role admin
    TOKEN=$(az grafana service-account token create -g My-app -n grafana-testing --service-account myAccount --token myToken --time-to-live 1d --query key  -o tsv)
    echo -n $TOKEN >> grafana_token.txt
    EOF

    interpreter = [ "bash", "-c" ]
  }
}

data "local_file" "grafana_token" {
  depends_on = [ terraform_data.grafana-sa ]
  filename = "${path.module}/grafana_token.txt"
}

output "grafana_token" {
  value = data.local_file.grafana_token.content
}