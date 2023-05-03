terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "1.30.0"
    }
  }
}

provider "linode" {
  token = var.access_token 
}

resource "linode_instance" "ctf-server" {
    label = "defense_server"
    image = "linode/debian10"
    region = "us-central"
    type = "g6-nanode-1"
    #authorized_keys = [file(var.root_key_path)]
    root_pass = var.root_pass

    group = "cloud_servers"
    tags = ["cloud_servers"]
    swap_size = 256
    private_ip = true
}

output "server_ip_address" {
  value = "${linode_instance.ctf-server.ipv4}"
}
