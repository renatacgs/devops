output "cloudwatch_log_group" {
  description = "CloudWatch Log Group Name"
  value       = aws_cloudwatch_log_group.app_log_group.name
}

output "autoscaling_group_ec2" {
  description = "EC2 Auto Scaling Group Name"
  value       = aws_autoscaling_group.ec2_auto_scaling.name
}

output "autoscaling_group_eks" {
  description = "EKS Auto Scaling Group Name"
  value       = aws_autoscaling_group.eks_asg.name
}

output "prometheus_url" {
  description = "Prometheus URL"
  value       = module.prometheus.endpoint
}

output "grafana_url" {
  description = "Grafana URL"
  value       = module.grafana.endpoint
}
