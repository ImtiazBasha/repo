# Getting myIP details
/*data "http" "myip" {
  url = "http://icanhazip.com"
}
*/
# Creating Bastion security group

resource "aws_security_group" "BastionSg" {
  name        = "BastionSg"
  description = "Allow TLS inbound traffic to Bastion Server"
  vpc_id      = aws_vpc.myVPC.id

  ingress {
    description      = "SSH to Admin"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    #cidr_blocks     = ["${chomp(data.http.myip.body)}/32"] 
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]    
  }

  tags = {
    Name = "BastionSg"
    Terraform = "True"
    Environment = "Dev"
  }
}

# Creating CICD security group
/*
resource "aws_security_group" "CICDSg" {
  name        = "CICDSg"
  description = "Allow TLS inbound traffic to CICD Server"
  vpc_id      = aws_vpc.myVPC.id

  ingress {
    description      = "SSH to Admin"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    #cidr_blocks     = ["${chomp(data.http.myip.body)}/32"] 
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]    
  }

  ingress {
    description      = "Allow to Jenkins"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    #cidr_blocks     = ["${chomp(data.http.myip.body)}/32"] 
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]    
  }

  tags = {
    Name = "CICDSg"
    Terraform = "True"
    Environment = "Dev"
  }
}
*/

# Creating apache security group

resource "aws_security_group" "apacheSg" {
  name        = "apacheSg"
  description = "Allow TLS inbound traffic to apache Server"
  vpc_id      = aws_vpc.myVPC.id

  ingress {
    description      = "SSH to Admin"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    #cidr_blocks     = ["${chomp(data.http.myip.body)}/32"] 
    #cidr_blocks     = ["0.0.0.0/0"]
    security_groups  = [aws_security_group.CICDSg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]    
  }

ingress {
    description      = "SSH to Enduser"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    #cidr_blocks     = ["${chomp(data.http.myip.body)}/32"] 
    cidr_blocks     = ["0.0.0.0/0"]
    #security_groups  = [aws_security_group.BastionSg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]    
  }
  

  tags = {
    Name = "apacheSg"
    Terraform = "True"
    Environment = "Dev"
  }
}

