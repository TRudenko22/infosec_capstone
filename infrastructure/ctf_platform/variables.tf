variable "access_token" {
    description = "Token provided by linode for access to API"
    #default = "null"
    default = "5a80a301db73be12c43968636b4cce5596c5c7b431c57d57a05c949c249270ca"
}

variable "root_pass" {
    description = "ssh password login for both machines"
    default = "pleasechangethepassword"
}

