terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = "2.15.0"
    }
  }
}

provider "aci" {
  username = "admin"
  password = var.apic_password
  url      = "https://10.122.18.27"
}

data "aci_tenant" "myTenant" {
  name = var.tenant_name
}

data "aci_vrf" "myVrf" {
  tenant_dn = data.aci_tenant.myTenant.id
  name      = var.vrf_name
}

resource "aci_application_profile" "myApp" {
  tenant_dn = data.aci_tenant.myTenant.id
  name      = var.app_name
}

resource "aci_bridge_domain" "myBd" {
  tenant_dn          = data.aci_tenant.myTenant.id
  name               = "VLAN${var.vlan_id}_BD"
  relation_fv_rs_ctx = data.aci_vrf.myVrf.id
}

resource "aci_application_epg" "myEpg" {
  application_profile_dn = aci_application_profile.myApp.id
  name                   = "VLAN${var.vlan_id}_EPG"
  relation_fv_rs_bd      = aci_bridge_domain.myBd.id
}

resource "aci_epg_to_static_path" "mySps" {
  for_each           = toset(var.interface_ids)
  application_epg_dn = aci_application_epg.myEpg.id
  tdn                = "topology/pod-1/paths-101/pathep-[${each.value}]"
  encap              = "vlan-${var.vlan_id}"
}