#Retriving availability zones
data "aws_availability_zones" "available" {
  state = "available"
}
#Creating public subnets
resource "aws_subnet" "publicSubnet" {
  count = length(var.pubcidr)
  vpc_id     = aws_vpc.myVPC.id
  availability_zone = element(data.aws_availability_zones.available.names,count.index)
  cidr_block = element(var.pubcidr,count.index)
  map_public_ip_on_launch = "true"

  tags = {
    Name = "publicSubnet${count.index+1}"
    Terraform = "True"
    Environment = "dev"
  }
}

