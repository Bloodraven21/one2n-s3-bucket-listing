resource "aws_vpc" "one2ntask" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.one2ntask.id
  cidr_block              = "10.0.2.0/24"  # Update this variable for the public subnet
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"           # You can change this to your preferred AZ
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.one2ntask.id
  cidr_block        = var.private_subnet_cidr       # Update this variable for the private subnet
  availability_zone = "ap-south-1a"                 # You can keep this as one AZ or have another private subnet in a different AZ.
}

resource "aws_internet_gateway" "one2ntask" {
  vpc_id = aws_vpc.one2ntask.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.one2ntask.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.one2ntask.id
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "one2ntask" {
  vpc = true
}

resource "aws_nat_gateway" "one2ntask" {
  subnet_id    = aws_subnet.public.id   # Use the public subnet for the NAT gateway
  allocation_id = aws_eip.one2ntask.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.one2ntask.id
}

resource "aws_route" "nat_access" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.one2ntask.id
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}