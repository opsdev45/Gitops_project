output "vpc_id" {
  value = aws_vpc.terraform-vpc.id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

