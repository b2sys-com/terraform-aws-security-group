resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = [for s in var.sg_inbound : {
      from_port       = s.from_port != null ? s.from_port : null
      to_port         = s.to_port != null ? s.to_port : null
      protocol        = s.protocol != null ? s.protocol : null
      cidr_blocks     = s.cidr_blocks != null ? s.cidr_blocks : null
      security_groups = s.security_groups != null ? s.security_groups : null
    }]

    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      security_groups = ingress.security_groups
      cidr_blocks     = ingress.value.cidr_blocks
    }
  }

  /*lifecycle {
    create_before_destroy = true
    ignore_changes        = [name]
  }*/

  tags = var.tags
}

resource "aws_security_group_rule" "allow_all_output" {
  description       = var.description
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}
