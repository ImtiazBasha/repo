#Creating Internet Gateway

resource "aws_internet_gateway" "myIGW" {
  vpc_id = aws_vpc.myVPC.id

  tags = {
    Name = "myVPC"
    Terraform = "True"
    Environment = "Dev"
  }
}

#Creating Public Route table

resource "aws_route_table" "publicRouteTable" {
  vpc_id = aws_vpc.myVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myIGW.id
  }

  tags = {
    Name = "publicRouteTable"
    Terraform = "True"
    Environment = "Dev"
  }
}

#Associating public route table

resource "aws_route_table_association" "PublicSubnetAssociation" {
  count = length(var.pubcidr)
  subnet_id      = aws_subnet.publicSubnet[count.index].id
  route_table_id = aws_route_table.publicRouteTable.id
}
