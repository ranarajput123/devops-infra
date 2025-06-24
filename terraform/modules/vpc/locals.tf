locals {
  vpc_name = "${var.vpc_name}-${var.env}-vpc"

  # 10.0.0.0/18- Ip range 10.0.0.0 - 10.0.63.255 - 16,384 ips
  private_subnet_cidr = cidrsubnet(var.vpc_main_cidr, 2, 0)

  # 10.0.64.0/19 - Ip range 10.0.64.0 to 10.0.95.255 - 8,192 ips
  pods_cidr = cidrsubnet(var.vpc_main_cidr, 3, 2)

  # 10.0.96.0/19 - Ip range 10.0.96.0 to 10.0.127.255 - 8,192 ips
  services_cidr = cidrsubnet(var.vpc_main_cidr, 3, 3)

  # 10.0.128.0/20 - Ip range 10.0.128.0 to 10.0.143.255
  master_node_cidr = cidrsubnet(var.vpc_main_cidr, 4, 8)

}
