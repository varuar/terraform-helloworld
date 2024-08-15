provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-033fabdd332044f06"
  instance_type = "t2.micro"

  # Ensure you have a security group for HTTP and SSH traffic
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  # Optional: specify the key name for SSH access
  key_name = "ec2keypair"

  tags = {
    Name = "HelloWorldInstance"
  }
}

resource "aws_security_group" "instance_sg" {
  name_prefix = "instance_sg_"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere; restrict for production use
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "instance_sg"
  }
}

output "public_ip" {
  value = aws_instance.example.public_ip
}
