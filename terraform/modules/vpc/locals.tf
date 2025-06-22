locals {
  vpc_name = "${var.vpc_name}-${var.env}-vpc"

  # 10.0.0.0/17- Ip range 10.0.0.0 to 10.0.127.255 - 32,768 ips
  private_subnet_cidr = cidrsubnet(var.vpc_main_cidr, 1, 0)

  # 10.0.128.0/19 - Ip range 10.0.128.0 to 10.0.159.255 - 8,192 ips
  pods_cidr = cidrsubnet(var.vpc_main_cidr, 3, 4)

  # 10.0.160.0/19 - Ip range 10.0.160.0 to 10.0.191.255 - 8,192 ips
  services_cidr = cidrsubnet(var.vpc_main_cidr, 3, 5)

}
