resource "aws_route_table" "public_route_table" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "pub-rt-${local.postfix_name}"
    }
  )
}

resource "aws_route_table" "private_route_table" {
  count = length(var.private_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "pvt-rt-${local.postfix_name}"
    }
  )
}

resource "aws_route" "public_int_gw_route" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.public_route_table[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway[0].id
}

resource "aws_route" "private_nat_gw_route" {
  count = var.enable_nat_gateway ? 1 : 0

  route_table_id         = aws_route_table.private_route_table[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway[0].id
}

resource "aws_route_table_association" "public_route_table_association" {
  count = length(var.public_subnets) > 0 && length(aws_route_table.public_route_table) > 0 ? length(aws_subnet.public_subnets) : 0

  route_table_id = aws_route_table.public_route_table[0].id
  subnet_id      = aws_subnet.public_subnets[count.index].id
}

resource "aws_route_table_association" "private_route_table_association" {
  count = length(aws_subnet.private_subnets) > 0 && length(aws_route_table.private_route_table) > 0 ? length(aws_subnet.private_subnets) : 0

  route_table_id = aws_route_table.private_route_table[0].id
  subnet_id      = aws_subnet.private_subnets[count.index].id
}