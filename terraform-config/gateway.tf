resource "aws_internet_gateway" "tp_3_final_2271627_internet_gw" {
  vpc_id = aws_vpc.tp_3_final_2271627_vpc.id

  tags = {
    Name = "TP-3-FINAL-2271627-INTERNET-GW"
  }
}
