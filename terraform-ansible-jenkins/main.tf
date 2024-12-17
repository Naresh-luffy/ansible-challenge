provider "aws" {
    region = "eu-north-1"
  
}

resource "aws_instance" "frontend" {
    ami = "ami-02a0945ba27a488b7"
    instance_type = "t3.large"
    key_name = "Linux-Testing"
    user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname c8.local
              sudo yum update -y
              echo "127.0.0.1 c8.local" >> /etc/hosts
              EOF

        tags = {
          Name = "frontend"
        }
}

resource "aws_instance" "backend" {
    ami = "ami-089146c5626baa6bf"
    instance_type = "t3.large"
    key_name = "Linux-Testing"
     user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname u21.local
              sudo apt-get update -y
              sudo apt-get upgrade -y
              echo "127.0.0.1 u21.local" >> /etc/hosts
              EOF
        tags = {
          Name = "backend"
        }
  
}
}
output "frontend_ip" {
  value = aws_instance.frontend.public_ip
}

output "backend_ip" {
  value = aws_instance.backend.public_ip
}



