resource "aws_vpc" "lakay_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev-env"
  }
}

resource "aws_subnet" "lakay_public_subnet" {
  vpc_id                  = aws_vpc.lakay_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "lakay-dev-pubsub"
  }
}

resource "aws_internet_gateway" "lakay_igw" {
  vpc_id = aws_vpc.lakay_vpc.id

  tags = {
    Name = "lakay-igw"
  }
}

resource "aws_route_table" "lakay_rt_public" {
  vpc_id = aws_vpc.lakay_vpc.id

  tags = {
    Name = "dev_public_rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.lakay_rt_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lakay_igw.id
}

resource "aws_route_table_association" "lakay_pub_assoc" {
  subnet_id      = aws_subnet.lakay_public_subnet.id
  route_table_id = aws_route_table.lakay_rt_public.id
}