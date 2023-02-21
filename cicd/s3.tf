resource "aws_s3_bucket" "imtiaz-artifactory" {
  bucket = "imtiaz-artifactory"

  tags = {
    Name        = "imtiaz-artifactory"
    Environment = "Stage"
    Terraform = "True"
  }
}