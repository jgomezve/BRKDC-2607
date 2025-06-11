# BRKDCN-2607: Insfrastructure as Code for ACI using Terraform

## Preparation

* Set the APIC's password as environmental variable

            export TF_VAR_apic_password=<APIC_PASSWORD>

## Execution

1. Download ACI Provider

            terraform init

2. Verify actions 

            terraform plan

3. Deploy configuration

            terraform apply auto-approve
            

## Notes

Tenant `tenant_name` and VRF `vrf_name` should already exist in the ACI Fabric