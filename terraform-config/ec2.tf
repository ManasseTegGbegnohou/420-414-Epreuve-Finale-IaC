variable "ami_id" {
  type        = string
  description = "Amazon Machine Image Id of EC2 Instance"
  default     = "ami-084568db4383264d4"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance Type"
  default     = "t2.micro"
}

resource "aws_instance" "multi_service_infrastructure" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.tp_3_final_2271627_public_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.tp_3_final_2271627_sg.id]
  key_name                    = aws_key_pair.tp_3_final_2271627key.key_name

  tags = {
    Name = "TP-3-FINAL-2271627-MULTI-SERVICE"
  }

  user_data = file("${path.module}/user-data.sh")
}

output "multi_service_infrastructure_public_ip" {
  description = "Public IP of MULTI SERVICE EC2 Instance"
  value       = try(aws_instance.multi_service_infrastructure.public_ip, "")
}
