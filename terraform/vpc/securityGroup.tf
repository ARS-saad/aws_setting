resource "aws_security_group" "travel_agency_sg_ec2" {
  name        = "travel_agency_sg_ec2"
  description = "Security group for Travel Agency EC2 Instance"
  vpc_id      = aws_vpc.travel_agency_vpc.id

  # Next.js Application Port
  ingress {
    description = "Next.js Production Port"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Standard Web Traffic
  ingress {
    description = "HTTP Public Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Administrative Access (Consider locking cidr_blocks down later)
  ingress {
    description = "SSH Administrative Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # Fixed ICMP Rule
  ingress {
    description = "Allow Ping Requests"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Jenkins Web UI port (Only keep if this specific instance hosts the dashboard UI)
  ingress {
    description = "Jenkins Dashboard Web UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Full Outbound Internet Access
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # Allows all protocols
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "travel_agency_sg_ec2"
  }
}
