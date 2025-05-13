output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subent_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subent_ids" {
  value = aws_subnet.private_subnets[*].id
}