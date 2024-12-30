resource "aws_ebs_volume" "data" {
  availability_zone = var.availability_zone
  size              = var.volume_size
}

resource "aws_volume_attachment" "attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.data.id
  instance_id = aws_instance.web.id
}

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "WebInstance"
  }
}