# Required variables for Terraform to run
# This variables need to be specified on a file called terraform.tfvars
# Example on terraform.tfvars:
# ```
#   aws_access_key = "AKIA..."
#   aws_secret_key = "..."
#   aws_region = "us-east-1"
# ```
# Arguments can also be specified on the command line with the -var flag
# when terraform plan or terraform apply is called

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "mongo_ami" {
  description = "Mongo Packer created AMI id"
  type        = string
}

variable "server_ami" {
  description = "Server Packer created AMI id"
  type        = string
}

variable "key_pair" {
  description = "Key pair to attach to instances"
  type        = string
}
