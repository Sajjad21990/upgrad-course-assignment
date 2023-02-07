resource "aws_key_pair" "assignment_key_pair" {
  key_name   = "assignment_key_pair"
  public_key = file("path/to/your/public_key.pub")
}