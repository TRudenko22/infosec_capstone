terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "1.30.0"
    }
  }
}

provider "linode" {
  # Configuration options
  token = var.access_token 
}

resource "linode_instance" "game_host" {
    label = "game_host"
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

resource "linode_instance" "attack_server" {
    label = "attack_server"
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

resource "linode_instance" "defense_server" {
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
	provisioner "remote-exec" {
	inline = [
#	  "curl -o bootstrap-salt.sh -L https://bootstrap.saltproject.io",
#	  "sh bootstrap-salt.sh -P stable 3004.1",
#	  "chmod +x /tmp/postinstall.sh",
#	  "/tmp/postinstall.sh",
	]
	}
	provisioner "file" {
	source = "minion"
	destination = "/etc/salt/minion"
	}
}
