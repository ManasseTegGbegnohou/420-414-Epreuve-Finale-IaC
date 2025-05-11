variable "public_subnet_cidrs" {
  type        = string
  description = "Public Subnet Address"
  default     = "10.0.0.0/24"
}

variable "private_subnet_cidrs" {
  type        = string
  description = "Private Subnet Address"
  default     = "10.0.1.0/24"
}

variable "azs" {
  type        = string
  description = "Availability Zone"
  default     = "us-east-1a"
}

resource "aws_subnet" "tp_3_final_2271627_public_subnet" {
  vpc_id            = aws_vpc.tp_3_final_2271627_vpc.id
  cidr_block        = var.public_subnet_cidrs
  availability_zone = var.azs

  tags = {
    Name = "TP-3-FINAL-2271627-PUBLIC-1"
  }
}

resource "aws_subnet" "tp_3_final_2271627_private_subnets" {
  vpc_id            = aws_vpc.tp_3_final_2271627_vpc.id
  cidr_block        = var.private_subnet_cidrs
  availability_zone = var.azs

  tags = {
    Name = "TP-3-FINAL-2271627-PRIVATE-1"
  }
}
