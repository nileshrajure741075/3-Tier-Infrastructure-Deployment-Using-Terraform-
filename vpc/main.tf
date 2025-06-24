# Custom_vpc creation
resource "aws_vpc" "custom_vpc" {
  cidr_block       = var.cidr_block

  tags = {
    Name = "custom_vpc"
  }
}

# internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "my_igw"
  }
}

# websubnet
resource "aws_subnet" "websubnet" {
  vpc_id = aws_vpc.custom_vpc.id
  cidr_block       = var.web-cidr_block
  availability_zone = "us-east-1a"
  tags = {
    Name = "websubnet"
  }
}

# appsubnet
resource "aws_subnet" "appsubnet" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = var.app-cidr_block
  availability_zone = "us-east-1b"
  tags = {
    Name = "appsubnet"
  }
}

# dbsubnet
resource "aws_subnet" "dbsubnet" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = var.db-cidr_block
  availability_zone = "us-east-1c"
  tags = {
    Name = "dbsubnet"
  }
}

# public Route table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# private Route table
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "private-rt"
  }
}

# main RT association
resource "aws_main_route_table_association" "main-rt-asso" {
  vpc_id         = aws_vpc.custom_vpc.id
  route_table_id = aws_route_table.public-rt.id
}

# websubnet association
resource "aws_route_table_association" "web_association" {
  subnet_id      = aws_subnet.websubnet.id
  route_table_id = aws_route_table.public-rt.id
}

# appsubnet association
resource "aws_route_table_association" "app_association" {
  subnet_id      = aws_subnet.appsubnet.id
  route_table_id = aws_route_table.private-rt.id
}

# dbsubnet association
resource "aws_route_table_association" "db_association" {
  subnet_id      = aws_subnet.dbsubnet.id
  route_table_id = aws_route_table.private-rt.id
}

#db_subnet-group
resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.appsubnet.id, aws_subnet.dbsubnet.id]

  tags = {
    Name = "My-db-subnet-group"
  }
}


