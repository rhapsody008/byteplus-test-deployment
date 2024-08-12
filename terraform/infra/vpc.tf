resource "byteplus_vpc" "this" {
  vpc_name   = "byteplus-test-deployment-vpc"
  cidr_block = "172.16.0.0/16"
}

resource "byteplus_subnet" "this_public" {
  subnet_name = "byteplus-test-deployment-public-subnet"
  cidr_block = "172.16.1.0/24"
  vpc_id = resource.byteplus_vpc.this.id
  zone_id = var.region
}

resource "byteplus_subnet" "this_private" {
  subnet_name = "byteplus-test-deployment-private-subnet"
  cidr_block = "172.16.2.0/24"
  vpc_id = resource.byteplus_vpc.this.id
  zone_id = var.region
}

