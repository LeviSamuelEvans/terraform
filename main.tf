# tell terraform which provider we would like to use
provider "aws" {
  region = "eu-north-1"
}

/*For each provder, we need to specify the type of 
resources we would like to create. In this case, we are
creating an instance. The instance resource is a part of the
aws provider.  */
resource "aws_instance" "example" {
  ami           =  "ami-07c8c1b18ca66bb07" # Ubuntui 20.04
  instance_type = "t3.micro"               # free tier [https://aws.amazon.com/ec2/instance-types/t3/]
  vpc_security_group_ids = [aws_security_group.instance.id] # we need to tell the instance to use the security group we created!
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "terraform-tutorial"
  }
}

/*By default, AWS does not allow any incoming or outgoing traffic 
from an EC2 instance, so we need to setup it up to allow traffic 
on port 8080 by creating a security group*/
resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # allow TCP requests from any IP address
  }
}

