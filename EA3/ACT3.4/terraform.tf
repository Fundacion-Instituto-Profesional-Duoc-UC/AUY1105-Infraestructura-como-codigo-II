provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-012967cc5a8c9f891"
  instance_type = "t2.micro"

  tags = {
    Name = "WebInstance"
  }
}

resource "aws_ebs_volume" "data" {
  availability_zone = "us-west-2a"
  size              = 10
}

resource "aws_volume_attachment" "attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.data.id
  instance_id = aws_instance.web.id
}
