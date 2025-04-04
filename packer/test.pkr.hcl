packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "source_ami" {
  type        = string
  default     = "ami-05a7f3469a7653972"  # ✅ 여기에 실제 AMI ID 넣기
  description = "Base AMI ID to start building from"
}

source "amazon-ebs" "ubuntu-ansible" {
  region           = "ap-northeast-2"
  source_ami       = var.source_ami      # ✅ 기존 Ubuntu AMI
  instance_type    = "t2.micro"
  ssh_username     = "ubuntu"
  ami_name         = "custom-ami-{{timestamp}}"
  ami_description  = "Customized AMI with Ansible provisioner"
}

build {
  name    = "build-ubuntu-with-ansible"
  sources = ["source.amazon-ebs.ubuntu-ansible"]
}