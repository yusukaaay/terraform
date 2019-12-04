variable "env" {}

# VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env}-vpc"
  } 

}

# パブリックサブネット 
resource "aws_subnet" "public-subnet01" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "${var.env}-public-subnet01"
  } 
}

resource "aws_subnet" "public-subnet02" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "${var.env}-public-subnet02"
  } 
}

resource "aws_subnet" "public-subnet03" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-1d"

  tags = {
    Name = "${var.env}-public-subnet03"
  } 
}



# インターネットゲートウェイ
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.env}-private-subnet03"
  } 
}

# ルートテーブル
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.env}-public-rtb"
  } 
}

# ルート
resource "aws_route" "public-rt" {
  route_table_id = aws_route_table.public-rtb.id
  gateway_id = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

# サブネットとルートテーブルの関連付け
resource "aws_route_table_association" "public01" {
  subnet_id = aws_subnet.public-subnet01.id
  route_table_id = aws_route_table.public-rtb.id
}

resource "aws_route_table_association" "public02" {
  subnet_id = aws_subnet.public-subnet02.id
  route_table_id = aws_route_table.public-rtb.id
}

resource "aws_route_table_association" "public03" {
  subnet_id = aws_subnet.public-subnet03.id
  route_table_id = aws_route_table.public-rtb.id
}


# プライベートサブネット 
resource "aws_subnet" "private-subnet01" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.11.0/24"
  map_public_ip_on_launch = false
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "${var.env}-private-subnet01"
  } 
}

resource "aws_subnet" "private-subnet02" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.12.0/24"
  map_public_ip_on_launch = false
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "${var.env}-private-subnet02"
  } 
}

resource "aws_subnet" "private-subnet03" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.13.0/24"
  map_public_ip_on_launch = false
  availability_zone = "ap-northeast-1d"

  tags = {
    Name = "${var.env}-private-subnet03"
  } 
}

# ルートテーブル
resource "aws_route_table" "private-rtb" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.env}-private-rtb"
  } 
}

# サブネットとルートテーブルの関連付け
resource "aws_route_table_association" "private01" {
  subnet_id = aws_subnet.private-subnet01.id
  route_table_id = aws_route_table.private-rtb.id
}

resource "aws_route_table_association" "private02" {
  subnet_id = aws_subnet.private-subnet02.id
  route_table_id = aws_route_table.private-rtb.id
}

resource "aws_route_table_association" "private03" {
  subnet_id = aws_subnet.private-subnet03.id
  route_table_id = aws_route_table.private-rtb.id
}



