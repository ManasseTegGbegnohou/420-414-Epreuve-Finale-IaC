resource "aws_vpc" "tp_3_final_2271627_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "TP-3-FINAL-2271627-VPC"
  }
}

variable "vpc_cidr" {
  type        = string
  description = "VPC Address Group"
  default     = "10.0.0.0/16"
}
