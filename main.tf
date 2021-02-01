provider "aws" {
  region = "us-east-2"
  access_key = "AKIAXA5UNWV5IPHEV3NP"
  secret_key = "6K/sAzTZHWZE6pYv27J8SmoEvXZt4Ks8mD/hhfm5"

}

resource "aws_instance" "example" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {

  name = "terraform-example-instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "terraform-example-instance"
}
output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP of the Instance"
}