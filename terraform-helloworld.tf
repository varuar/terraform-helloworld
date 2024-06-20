provider "aws" {
  region = "us-east-2"  
}

resource "aws_instance" "example" {
  ami           = "ami-033fabdd332044f06"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorldInstance"
  }
}

output "instance_id" {
  value = aws_instance.example.id
}



