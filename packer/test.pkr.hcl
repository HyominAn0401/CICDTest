packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "instance_id" {
  type        = string
  default     = "i-00f7635259be3754e"
  description = "EC2 Instance ID"
}

source "amazon-ebs" "existing-ec2" {
  region             = "ap-northeast-2"
  instance_id        = var.instance_id         # ✅ 기존 EC2를 직접 지정
  ssh_username       = "ubuntu"                # 사용 중인 AMI에 따라 ec2-user 등으로 수정
  ami_name           = "custom-ami-{{timestamp}}"
  ami_description    = "Created from an existing EC2 with Ansible"
  skip_stop_instance = false                   # 필요 시 true로 재부팅 없이 생성 가능
}

build {
  name    = "create-ami-from-existing-ec2"
  sources = ["source.amazon-ebs.existing-ec2"]
}