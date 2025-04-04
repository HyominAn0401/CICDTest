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

source "amazon-ebs" "ubuntu-ansible" {
  region           = "ap-northeast-2"
  source_ami       = var.base_ami
  instance_type    = "t2.micro"
  ssh_username     = "ubuntu"

  ami_name         = "custom-ami-from-ansible-{{timestamp}}"
  ami_description  = "Created by Packer + Ansible with fixed VPC setting"

  subnet_id        = "subnet-0f145b66fff04c74c"     
  security_group_id = "sg-0817758f51fa89740" 
  associate_public_ip_address = true
}

build {
  name    = "build-ubuntu-with-ansible"
  sources = ["source.amazon-ebs.ubuntu-ansible"]
}