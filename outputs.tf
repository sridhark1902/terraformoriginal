
output "vpc-name" {
 value = "${aws_vpc.default.tags.Name}"
}


output "IGW-name" {
 value = "${aws_internet_gateway.default.tags.Name}"
}


output "vpc-id" {
 value = "${aws_vpc.default.id}"
}


output "IGW-id" {
 value = "${aws_internet_gateway.default.id}"
}

# output "bucket-name" {
#  value = "${aws_s3_bucket.bucket-1.tags.Name}"
# }

