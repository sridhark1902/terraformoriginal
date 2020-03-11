#This Terraform Code Deploys Basic VPC Infra.
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "${var.vpc_name}"
    }
    depends_on = ["aws_s3_bucket.bucket-1"]
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
	tags = {
        Name = "${var.IGW_name}"
    }
}

resource "aws_s3_bucket" "bucket-1" {
  bucket = "sripallavi0010"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "test"
  }
}




resource "aws_subnet" "subnets" {
    count = "${length(var.cidrs)}"
    vpc_id = "${aws_vpc.default.id}"
    availability_zone = "${element(var.azs, count.index)}"
    cidr_block = "${element(var.cidrs, count.index)}"
	map_public_ip_on_launch = true
    
    tags = {
        Name = "${var.vpc_name}-subnet-${count.index+1}"
        Owner = "Infosys"
    }
}



resource "aws_route_table" "terraform-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags = {
        Name = "${var.Main_Routing_Table}"
    }
}



resource "aws_route_table_association" "terraform-public" {
    count = "${length(var.cidrs)}"
    subnet_id = "${element(aws_subnet.subnets.*.id, count.index)}"
    route_table_id = "${aws_route_table.terraform-public.id}"
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.default.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    }
}


#data "aws_ami" "my_ami" {
#    most_recent      = true
#   #name_regex       = "^sridhark"
#     owners           = ["721834156908"]
#}

terraform {
backend "s3" {
bucket = "sripallavi0010"
region = "us-east-1"
key = "terraform10.state"
}
}


# resource "aws_instance" "web-1" {
#     count = "${length(var.cidrs)}"
#     #ami = "${data.aws_ami.my_ami.id}"
#      ami =  "${lookup (var.amis, var.aws_region)}"
#      availability_zone = "${element(var.azs, count.index)}"
#      instance_type = "t2.micro"
#      key_name = "${var.key_name}"
#     subnet_id = "${element(aws_subnet.subnets.*.id, count.index)}"
#     #subnet_id = "${element(aws_subnet.subnets.*.id, count.index)}"
#      vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
#      associate_public_ip_address = true	
#      user_data = <<-EOF
# #!/bin/bash
# yum update -y
# yum  install nginx -y
# service nginx start
# EOF
#      tags = {
#          Name = "Server-${count.index+1}"
#          Env = "Prod"
#          Owner = "Sree"
#      }
#  }


 



# output "ami_id" {
#  value = "${data.aws_ami.my_ami.id}"
# }
#!/bin/bash
# echo "Listing the files in the repo."
# ls -al
# echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
# echo "Running Packer Now...!!"
# packer build -var 'aws_access_key=AAAAAAAAAAAAAAAAAA' -var 'aws_secret_key=BBBBBBBBBBBBB' packer.json
# echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
# echo "Running Terraform Now...!!"
# terraform init
# terraform apply --var-file terraform.tfvars -var="aws_access_key=AAAAAAAAAAAAAAAAAA" -var="aws_secret_key=BBBBBBBBBBBBB" --auto-approve
