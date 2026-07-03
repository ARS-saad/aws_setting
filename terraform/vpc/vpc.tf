//vpc create
resource "aws_vpc" "travel_agency_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

//public subnet 1 create
resource "aws_subnet" "travel_agency_public_subnet_1" {
  vpc_id                  = aws_vpc.travel_agency_vpc.id
  cidr_block              = var.PubSub1CIDR
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}a"
  tags = {
    Name = var.pubsub_1_name
  }
}

//public subnet 2 create
resource "aws_subnet" "travel_agency_public_subnet_2" {
  vpc_id                  = aws_vpc.travel_agency_vpc.id
  cidr_block              = var.PubSub2CIDR
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}b"
  tags = {
    Name = var.pubsub_2_name
  }
}

//internet gateway create
resource "aws_internet_gateway" "travel_agency_igw" {
  vpc_id = aws_vpc.travel_agency_vpc.id
  tags = {
    Name = var.igw_name
  }
}

//public route table create
resource "aws_route_table" "travel_agency-public-rt" {
  vpc_id = aws_vpc.travel_agency_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.travel_agency_igw.id
  }
}

//associate public route table with public subnet 1
resource "aws_route_table_association" "travel_agency_rta_public_subnet_1" {
  subnet_id      = aws_subnet.travel_agency_public_subnet_1.id
  route_table_id = aws_route_table.travel_agency-public-rt.id
}

//associate public route table with public subnet 2
resource "aws_route_table_association" "travel_agency_rta_public_subnet_2" {
  subnet_id      = aws_subnet.travel_agency_public_subnet_2.id
  route_table_id = aws_route_table.travel_agency-public-rt.id
}

//EKS security group and EKS module
module "sgs" {
  source = "../sg_eks"
  vpc_id = aws_vpc.travel_agency_vpc.id
}

module "eks" {
  source     = "../eks"
  vpc_id     = aws_vpc.travel_agency_vpc.id
  subnet_ids = [aws_subnet.travel_agency_public_subnet_1.id, aws_subnet.travel_agency_public_subnet_2.id]
  sg_ids     = module.sgs.security_group_public
}
