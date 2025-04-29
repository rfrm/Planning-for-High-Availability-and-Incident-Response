output "aws_instance" {
  value = aws_instance.ubuntu
}

output "aws_instance_ids" {
  value = aws_instance.ubuntu.*.id
}

output "ec2_sg" {
  value = aws_security_group.ec2_sg.id
}
