resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.PROJECT}-${var.ENV}-IG"
  }
}
resource "aws_eip" "NAT" {}

resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.NAT.id
  subnet_id     = aws_subnet.public.*.id[0]

  tags = {
    Name = "${var.PROJECT}-${var.ENV}-NAT"
  }
}

resource "aws_route" "ig-route-public-subnet" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.IG.id
}

resource "aws_route" "nat-route-private-subnet" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.NAT.id
}