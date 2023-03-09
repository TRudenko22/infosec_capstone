variable "access_token" {
    description = "Token provided by linode for access to API"
    default = "null"
}

variable "root_key_path" {
    description = "ssh keypair path for linode instances"
    default = "~/.ssh/linode.pub"
}

variable "root_pass" {
    description = "ssh password login for both machines"
    default = "pleasechangethepassword"
}
