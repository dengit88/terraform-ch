
output "ec2_public_ip" {
  value = module.webserver-modules.instance.public_ip
}
