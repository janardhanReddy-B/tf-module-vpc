resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.PROJECT}-${var.ENV}-IG"
  }
}
resource "aws_eip" "NAT" {
  tags = {
    Name = "${var.PROJECT}-${var.ENV}-for nat"
  }
}

resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.NAT.id
  subnet_id     = aws_subnet.public.*.id[0]

  tags = {
    Name = "${var.PROJECT}-${var.ENV}-NAT"
  }
}

