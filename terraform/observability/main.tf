provider "aws" {
  region = "sa-east-1" 
}

# Configura o CloudWatch Log Group
resource "aws_cloudwatch_log_group" "app_log_group" {
  name              = "/aws/eks/cluster-logs"
  retention_in_days = 7
}

# Configura o CloudWatch Metrics para monitoramento do EKS e EC2
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "HighCPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  alarm_actions = [
    "arn:aws:sns:sa-east-1:123456789012:my-sns-topic"
  ]
}

# Configura o Auto Scaling para instâncias EC2
resource "aws_autoscaling_group" "ec2_auto_scaling" {
  launch_configuration = aws_launch_configuration.ec2_launch_config.id
  min_size              = 2
  max_size              = 10
  desired_capacity      = 2

  tag {
    key                 = "Name"
    value               = "MyAutoScalingGroup"
    propagate_at_launch = true
  }
}

# Configura o Auto Scaling para o Cluster EKS
resource "aws_autoscaling_policy" "eks_auto_scaling" {
  name                   = "scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.eks_asg.name
}

# Prometheus & Grafana (Normalmente, estes seriam configurados no EKS)
module "prometheus" {
  source = "terraform-aws-modules/prometheus/aws"
}

module "grafana" {
  source = "terraform-aws-modules/grafana/aws"
}
