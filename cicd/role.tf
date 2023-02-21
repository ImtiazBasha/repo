#Creating s3 role
resource "aws_iam_role" "s3role" {
  name = "s3role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]
})

  tags = {
    Name = "s3role"
    Environment = "Stage"
    Terraform = "True"
  }
}

#Creating policy  
resource "aws_iam_policy" "s3policy" {
  name        = "s3policy"
  path        = "/"
  description = "S3 test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
		"Version": "2012-10-17",
		"Statement": [
			{
				"Effect": "Allow",
				"Action": [
					"s3:*"
				],
				"Resource": "*"
			}
		]
	})
}

#Attaching policy
resource "aws_iam_role_policy_attachment" "s3-attach" {
  role       = aws_iam_role.s3role.name
  policy_arn = aws_iam_policy.s3policy.arn
}


# Creating Instance Profile
resource "aws_iam_instance_profile" "s3_profile" {
  name = "s3_profile"
  role = aws_iam_role.s3role.name
}