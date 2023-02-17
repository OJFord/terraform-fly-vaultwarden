output "app_name" {
  description = "Fly.io app name"
  value       = fly_app.this.name
}

output "url" {
  description = "Vaultwarden URL"
  value       = fly_app.this.appurl
}
