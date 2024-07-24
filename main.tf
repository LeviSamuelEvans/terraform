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

  tags = {
    Name = "terraform-tutorial"
  }
}

