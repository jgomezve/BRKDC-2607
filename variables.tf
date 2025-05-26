
variable "apic_password" {
  description = "Password of APIC Controller"
  type        = string
}

variable "tenant_name" {
  description = "Name of the Tenant"
  type        = string
}

variable "vrf_name" {
  description = "Name of the VRF"
  type        = string
}

variable "app_name" {
  description = "Name of the Application Profile"
  type        = string
}

variable "vlan_id" {
  description = "VLAN ID"
  type        = number
}

variable "interface_ids" {
  description = "Interfaces to configure Static Path"
  type        = list(string)
}
