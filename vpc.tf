resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = merge(
    local.common_tags,
    {
      Name = local.postfix_name
    }
  )
}