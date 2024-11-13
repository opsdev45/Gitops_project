resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Project VPC"
  }
}
# need to modify
locals {
  availability_zones = ["eu-west-2a", "eu-west-2b"]
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidrs)

  vpc_id     = aws_vpc.terraform-vpc.id
  cidr_block = var.public_subnet_cidrs[count.index]

  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = local.availability_zones[count.index]

  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = "Project VPC IG"
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets[0].id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  count = length(var.private_subnet_cidrs)

  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Route Table for public subnet"
  }
}

resource "aws_route_table_association" "public_subnet_asso" {
  count = length(var.public_subnet_cidrs)

  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}