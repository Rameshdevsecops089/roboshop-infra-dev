module "user"{
    source = "../../terrafrom-aws-roboshop"
    component = "user"
    rule_priority = 20
}