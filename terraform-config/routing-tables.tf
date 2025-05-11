resource "aws_route_table" "tp_3_final_2271627_public_rt" {
  vpc_id = aws_vpc.tp_3_final_2271627_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tp_3_final_2271627_internet_gw.id
  }
  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = "RTB-TP-3-FINAL-2271627-PUBLIC"
  }
}

resource "aws_route_table" "tp_3_final_2271627_private_rt" {
  vpc_id = aws_vpc.tp_3_final_2271627_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = "RTB-TP-3-FINAL-2271627-PRIVATE"
  }
}

# Association sous-réseaux public/tables de routage
resource "aws_route_table_association" "tp_3_final_2271627_public_subnet_association" {
  subnet_id      = aws_subnet.tp_3_final_2271627_public_subnet.id
  route_table_id = aws_route_table.tp_3_final_2271627_public_rt.id
}

# Association sous-réseaux private/tables de routage
resource "aws_route_table_association" "tp_3_final_2271627_private_subnet_association" {
  subnet_id      = aws_subnet.tp_3_final_2271627_private_subnets.id
  route_table_id = aws_route_table.tp_3_final_2271627_private_rt.id
}
