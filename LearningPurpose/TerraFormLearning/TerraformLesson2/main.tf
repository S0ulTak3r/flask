provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "example2" {
  ami           = "ami-040d60c831d02d41c"
  instance_type = "t3.micro"
  key_name      = "Daniel"

  vpc_security_group_ids = ["sg-08806de8191d050c4"]

  iam_instance_profile = "AccessS3"

  tags = {
    Name        = "terraform-example"
    Environment = "Prod123"
    Project     = "TerraformProject"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/Daniel.pem")
    host        = self.public_ip
  }

  provisioner "local-exec" {
    command = <<-EOF
      until ssh -o StrictHostKeyChecking=no -i ~/.ssh/Daniel.pem ec2-user@${self.public_ip} exit; do
        echo 'Waiting for SSH to become available...'
        sleep 5
      done
      ansible-playbook -i '${self.public_ip},' installLocalTerraformTest.yml
      scp -o StrictHostKeyChecking=no -i ~/.ssh/Daniel.pem docker-compose.yml ec2-user@${self.public_ip}:~
    EOF
  }


  provisioner "remote-exec" {
    inline = [
      "docker-compose down",
      "docker-compose pull",
      "docker-compose up --no-build -d"
    ]
  }
}
