resource "aws_route_table" "public" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.pre_fix}-pub-rt"
    }
  )
}

resource "aws_route_table" "private" {
  count = length(var.private_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.pre_fix}-pvt-rt"
    }
  )
}

resource "aws_route" "public_int_gw_route" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet[0].id
}

resource "aws_route" "private_nat_gw_route" {
  count = var.enable_nat_gateway ? 1 : 0

  route_table_id         = aws_route_table.private[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[0].id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets) > 0 && length(aws_route_table.public) > 0 ? length(aws_subnet.public) : 0

  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.public[count.index].id
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private) > 0 && length(aws_route_table.private) > 0 ? length(aws_subnet.private) : 0

  route_table_id = aws_route_table.private[0].id
  subnet_id      = aws_subnet.private[count.index].id
}