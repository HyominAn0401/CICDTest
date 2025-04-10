packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "base_ami" {
  type        = string
  default     = "ami-05a7f3469a7653972"
}

variable "subnet_id" {
  type      = string
}

variable "security_group_id" {
  type       = string
}

source "amazon-ebs" "ubuntu-ansible" {
  region           = "ap-northeast-2"
  source_ami       = var.base_ami
  instance_type    = "t2.micro"
  ssh_username     = "ubuntu"

  ami_name         = "custom-ami-from-ansible-{{timestamp}}"
  ami_description  = "Created by Packer + Ansible with fixed VPC setting"

  subnet_id        = var.subnet_id 
  security_group_id = var.security_group_id
  associate_public_ip_address = true
}

build {
  name    = "build-ubuntu-with-ansible"
  sources = ["source.amazon-ebs.ubuntu-ansible"]
}
