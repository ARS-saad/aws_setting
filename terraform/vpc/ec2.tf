resource "aws_key_pair" "ssh_key" {
  key_name   = var.key_pair_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "my_ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.travel_agency_public_subnet_1.id
  vpc_security_group_ids      = [aws_security_group.travel_agency_sg_ec2.id]
  key_name                    = aws_key_pair.ssh_key.key_name
  associate_public_ip_address = true
  for_each                    = toset(["frontend-server"]) //, "ansible"

  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "${each.key}"
  }
}
