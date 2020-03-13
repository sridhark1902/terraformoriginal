variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "amis" {
    description = "AMIs by region"
    default = {
    us-east-1 = "ami-08bc77a2c7eb2b1da" # ubuntu 16.04 LTS
		# us-east-2 = "ami-08cec7c429219e339" # ubuntu 16.04 LTS
		# us-east-1 = "ami-0e2ff28bfb72a4e45" # Amazon Linux 
		# us-east-2 = "ami-0998bf58313ab53da" # Amazon Linux 
    }
}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "IGW_name" {}
variable "key_name" {}
variable "public_subnet1_cidr" {}
variable "public_subnet2_cidr" {}
variable "public_subnet3_cidr" {}
variable "private_subnet_cidr" {}
variable "public_subnet1_name" {}
variable "public_subnet2_name" {}
variable "public_subnet3_name" {}
variable "private_subnet_name" {}
variable Main_Routing_Table {}
variable "azs" {

  description = "Run the EC2 Instances in these Availability Zones"
  type = "list"
  default = ["us-east-1a"]
}

variable "cidrs" {

  description = " cidrs blocks for the subnets"
  type = "list"
  default = ["10.25.1.0/24"]
}

variable "environment" { default = "test" }
variable "instance_type" {
  type = "map"
  default = {
    dev = "t2.nano"
    test = "t2.micro"
    prod = "t2.medium"
    }
}


