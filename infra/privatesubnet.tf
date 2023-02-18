#Creating Elastic IP
resource "aws_eip" "PrivateElasticIP" {
  vpc      = true
    tags = {
    Name = "PrivateMyNATgw"
    Terraform = "True"
    Environment = "Dev"
  }
  
}

# Creating NAT gateway

resource "aws_nat_gateway" "PrivateMyNATgw" {
  allocation_id = aws_eip.PrivateElasticIP.id
  subnet_id     = aws_subnet.publicSubnet[0].id

  tags = {
    Name = "PrivateMyNATgw"
    Terraform = "True"
    Environment = "Dev"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.myIGW]
}

# Creating Private Route Table

resource "aws_route_table" "PrivateRouteTable" {
  vpc_id = aws_vpc.myVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.PrivateMyNATgw.id
  }

   tags = {
    Name = "PrivateRouteTable"
    Terraform = "True"
    Environment = "Dev"
  }
}

# Associating Private and Data subnets

resource "aws_route_table_association" "PrivateSubnetAssoication" {
  count = length(var.privatecidr)
  subnet_id      = aws_subnet.privatesubnet[count.index].id
  route_table_id = aws_route_table.PrivateRouteTable.id
}

resource "aws_route_table_association" "DataSubnetAssoication" {
  count = length(var.datacidr)
  subnet_id      = aws_subnet.datasubnet[count.index].id
  route_table_id = aws_route_table.PrivateRouteTable.id
}