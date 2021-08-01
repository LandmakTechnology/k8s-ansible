variable "aws_region" {
  default = "us-west-2"
}

variable "key_name" {
  default = "key24"
}
variable "vpc_cidr" {
  default = "172.0.0.0/24"
}
variable "subnets_cidr" {
  type    = list(string)
  default = ["172.0.0.0/25", "172.0.0.128/25"]
}
variable "availability_zones" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b"]
}
variable "kubernetes_ami" {
  default = "ami-090717c950a5c34d3"
}
variable "master_instance_type" {
  default = "t2.medium"
}
variable "worker_instance_type" {
  default = "t2.micro"
}
