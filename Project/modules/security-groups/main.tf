resource "aws_security_group" "ec2" {
  name        = "${var.name}-ec2-sg"
  description = "Security group for EC2 Auto Scaling instances"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from within the VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "Outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.name}-ec2-sg"
  })
}