resource "aws_ecr_repository" "name" {
  image_tag_mutability = "MUTABLE"
  name = "capstone"
}