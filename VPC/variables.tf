/* @Indra
 Demo VPC varaibles file. Make sure you replace key_name value
 with your key name which  you have in given aws_region.
*/
variable "aws_region" {
  default = "us-east-1d"
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
  default = ["us-east-1d", "us-east-1c"]
}
variable "kubernetes_ami" {
  default = "ami-0c4f7023847b90238"
}
variable "key_name" {
  default = "DevopsBatchMithun"
}
variable "master_instance_type" {
default = "t2.medium"
}
variable "worker_instance_type" {
default = "t2.micro"
}
