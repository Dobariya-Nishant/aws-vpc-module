output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subent_ids" {
  value = aws_subnet.public[*].id
}

output "private_subent_ids" {
  value = aws_subnet.private[*].id
}