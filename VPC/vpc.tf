# Provider
provider "aws" {
  region = "us-east-1d"
}
# VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  #enable_dns_hostnames = true
  tags = {
    Name = "kubernetes"
  }
}
# IGW for demo_vpc
resource "aws_internet_gateway" "kubernetes_vpc_igw" {
  vpc_id = aws_vpc.kubernetes.id
  tags = {
    Name = "kubernetes_vpc_igw"
  }
}

# Subenets in demo_vpc
resource "aws_subnet" "subnets" {
  count                   = length(var.subnets_cidr)
  vpc_id                  = aws_vpc.kubernetes.id
  cidr_block              = element(var.subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "kubernetes_subnet_${count.index + 1}"
  }
}
# Route table for demo_vpc
resource "aws_route_table" "kubernetes_public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kubernetes_vpc_igw.id
  }
  tags = {
    Name = "kubernetes_vpc_public_rt"
  }
}

# Route table and subnets assocation
resource "aws_route_table_association" "rt_sub_association" {
  count          = length(var.subnets_cidr)
  subnet_id      = element(aws_subnet.kubernetes_subnets.*.id, count.index)
  route_table_id = aws_route_table.kubernetes_public_rt.id
}
