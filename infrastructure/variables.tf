variable "access_token" {
    description = "Token provided by linode for access to API"
#    default = "null"
    default = "034c8c78475a6e9cec6e32d1f42c8205d5fb5068fb0b96fd1f7e747257950513"
}

variable "root_key_path" {
    description = "ssh keypair path for linode instances"
    default = "~/.ssh/linode.pub"
}

variable "root_pass" {
    description = "ssh password login for both machines"
    default = "pleasechangethepassword"
}

