variable "access_token" {
    description = "Token provided by linode for access to API"
    #default = "null"
    default = "5a80a301db73be12c43968636b4cce5596c5c7b431c57d57a05c949c249270ca"
}

variable "root_key_path" {
    description = "ssh keypair path for linode instances"
    default = "~/.ssh/linode.pub"
}

variable "private_key_path" {
  description = "ssh private key path"
  default = "~/.ssh/linode"
}

variable "root_pass" {
    description = "ssh password login for both machines"
    default = "pleasechangethepassword"
}

