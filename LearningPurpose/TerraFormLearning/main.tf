provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "example" {
  ami           = "ami-012590f12ed6e00fd"
  instance_type = "t3.micro"
  key_name      = "oks"

  vpc_security_group_ids = ["sg-00595ba221e421a3c"]  # Replace with your security group ID(s) for this VPC

  iam_instance_profile = "Access-S3+EC2"  # Replace with the IAM role name or ARN

  tags = {
    Name        = "terraform-example"
    Environment = "Test123"
    Project     = "TerraformProject"
  }

  // Connection details for the remote-exec provisioner
  connection {
    type        = "ssh"
    user        = "ec2-user"  # For Amazon Linux
    private_key = file("~/.ssh/oks.pem")  # Replace with the actual path to your private key file
    host        = self.public_ip
  }

  // Run commands to install and start Nginx on the instance (Amazon Linux 2)
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
    ]
  }
}

output "public_ip" {
  value = aws_instance.example.public_ip
}

resource "aws_instance" "example2" {
  ami           = "ami-012590f12ed6e00fd"
  instance_type = "t3.micro"
  key_name      = "oks"

  vpc_security_group_ids = ["sg-00595ba221e421a3c"]  # Replace with your security group ID(s) for this VPC

  iam_instance_profile = "Access-S3+EC2"  # Replace with the IAM role name or ARN

  tags = {
    Name        = "terraform-example"
    Environment = "Prod123"
    Project     = "TerraformProject"
  }

  // Connection details for the remote-exec provisioner
  connection {
    type        = "ssh"
    user        = "ec2-user"  # For Amazon Linux
    private_key = file("~/.ssh/oks.pem")  # Replace with the actual path to your private key file
    host        = self.public_ip
  }

  // Run commands to install and start Nginx on the instance (Amazon Linux 2)
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
    ]
  }
}

output "public_ip_2" {
  value = aws_instance.example2.public_ip
}