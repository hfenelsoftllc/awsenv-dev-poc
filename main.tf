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

