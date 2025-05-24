resource "aws_internet_gateway" "internet" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.pre_fix}-int-gw"
    }
  )
}

resource "aws_nat_gateway" "nat" {
  count = var.enable_nat_gateway == true ? 1 : 0

  subnet_id     = aws_subnet.public_subnets[0].id
  allocation_id = aws_eip.nat[0].id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.pre_fix}-nat-gw"
    }
  )
}