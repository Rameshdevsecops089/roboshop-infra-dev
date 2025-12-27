module "frontend_alb" {
  source = "terraform-aws-modules/alb/aws"
  version = "9.16.0"
  internal = false
  name    = "${var.project}-${var.environment}-frontend-alb"
  vpc_id  = local.vpc_id
  subnets = local.public_subnet_id
  create_security_group = false
  security_groups = [local.frontend_alb_sg_id]
  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-frontend-alb"
    }
  )
}

resource "aws_lb_listener" "frontend-alb" {
  load_balancer_arn = module.frontend-alb.arn
  port              = "443"
  protocol          = "HTTPs"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = local.acm_certificate_arm
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, i am from frontend ALB using HTTPS</h1>"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "frontend_alb" {
  zone_id = var.zone_id
  name    = "*.${var.zone_name}" #.daws84s.site
  type    = "A"

  alias {
    name                   = module.frontend_alb.dns_name
    zone_id                = module.frontend_alb.zone_id # This is the ZONE ID of ALB
    evaluate_target_health = false
  }
}