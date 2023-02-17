terraform {
  required_providers {
    fly = {
      source  = "fly-apps/fly"
      version = "~> 0.0.21"
    }
  }
}

resource "random_pet" "this" {
  prefix = "vaultwarden"
}

resource "fly_app" "this" {
  name = random_pet.this.id
}

resource "fly_volume" "data" {
  app    = fly_app.this.id
  region = var.region
  name   = "data"
  size   = var.size_gb
}

resource "fly_machine" "server" {
  app    = fly_app.this.id
  region = var.region
  image  = "vaultwarden/server:${var.vaultwarden_version}-alpine"

  env = var.env

  mounts = [
    {
      path      = "/data"
      volume    = fly_volume.data.id
      encrypted = true
    },
  ]

  services = [
    {
      ports = [
        {
          port     = 443
          handlers = ["tls", "http"]
        },
      ]
      protocol      = "tcp"
      internal_port = 80
    },
  ]
}

resource "fly_ip" "this" {
  app  = fly_app.this.id
  type = "v6"
}
