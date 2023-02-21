#Creating CICD server

resource "aws_instance" "CICDServer" {
  ami           = "ami-05bfbece1ed5beb54"
  subnet_id = aws_subnet.publicSubnet[0].id
  availability_zone = data.aws_availability_zones.available.names[0]
  iam_instance_profile = aws_iam_instance_profile.s3_profile.name
  vpc_security_group_ids = [aws_security_group.CICDSg.id]
  instance_type = "t2.micro"
  key_name = "OhioLocalKey"
  user_data = "${file("jenkins.sh")}"
    
  tags = {
    Name = "CICDServer"
    Terraform = "True"
    Environment = "Dev"
  }
}

#Creating apache server
resource "aws_instance" "apacheServer" {
  ami           = "ami-05bfbece1ed5beb54"
  subnet_id = aws_subnet.publicSubnet[1].id
  availability_zone = data.aws_availability_zones.available.names[1]
  vpc_security_group_ids = [aws_security_group.apacheSg.id]
  instance_type = "t2.micro"
  key_name = "OhioLocalKey"
  user_data = "${file("apache.sh")}"

  tags = {
    Name = "apacheServer"
    Terraform = "True"
    Environment = "Dev"
  }
}

#Creating tomcat server
resource "aws_instance" "tomcatServer" {
  ami           = "ami-05bfbece1ed5beb54"
  subnet_id = aws_subnet.publicSubnet[1].id
  availability_zone = data.aws_availability_zones.available.names[1]
  vpc_security_group_ids = [aws_security_group.tomcatSg.id]
  instance_type = "t2.micro"
  key_name = "OhioLocalKey"
  user_data = "${file("tomcat.sh")}"

  tags = {
    Name = "tomcatServer"
    Terraform = "True"
    Environment = "Dev"
  }
}