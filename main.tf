provider "aws" {
  region = "us-east-2"
access_key = "AKIA4VBIC52MMGL6YPOG"
secret_key = "AYn7SIq8kNQLo3ob9NufQ6qNv5PO4UvnYqR8MEpd"

}
resource "aws_instance" "example" {
  ami          = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    "Name" = "terraform-examplebenji"
  }
}