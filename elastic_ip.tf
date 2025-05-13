resource "aws_eip" "nat" {
  count  = var.enable_nat_gateway == true ? 1 : 0
  domain = "vpc"

  tags = merge(
    local.common_tags,
    {
      Name = "nat-gw-eip-${local.postfix_name}"
    }
  )
}