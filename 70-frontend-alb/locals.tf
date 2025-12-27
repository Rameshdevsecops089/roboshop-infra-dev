locals {
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    private_subnet_id = split ("," , data.aws_ssm_parameter.private_subnet_ids.value)[0]
    frontend_alb_sg_id = data.aws_ssm_parameter.backend_alb_sg_id.value
    acm_certificate_arm = data.aws_ssm_parameter.acm_certificate_arm.value
    common_tags = {
        Project = var.project
        Environment = var.environment
        Terraform = "true"
    }
}