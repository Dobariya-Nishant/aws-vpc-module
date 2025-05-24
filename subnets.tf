resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.vpc.id
  availability_zone = element(var.availability_zones, count.index % length(var.availability_zones))
  cidr_block        = element(var.public_subnets, count.index)

  tags = merge(
    local.common_tags,
    {
      Name = "${local.pre_fix}-pub-sub-${element(var.availability_zones, count.index % length(var.availability_zones))}"
    }
  )
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.vpc.id
  availability_zone = element(var.availability_zones, count.index % length(var.availability_zones))
  cidr_block        = element(var.private_subnets, count.index)

  tags = merge(
    local.common_tags,
    {
      Name = "${local.pre_fix}-pvt-sub-${element(var.availability_zones, count.index % length(var.availability_zones))}"
    }
  )
}