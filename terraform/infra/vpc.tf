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

resource "byteplus_nat_gateway" "this" {
  vpc_id           = byteplus_vpc.this.id
  subnet_id        = byteplus_subnet.this_public.id
  spec             = "Small"
  nat_gateway_name = "byteplus-test-deployment-ng"
  description      = "byteplus-test-deployment"
}

resource "byteplus_route_table" "this" {
  vpc_id           = byteplus_vpc.this.id
  route_table_name = "byteplus-test-deployment"
  description      = "byteplus-test-deployment"
}

resource "byteplus_route_table_associate" "this" {
  route_table_id = byteplus_route_table.this.id
  subnet_id      = byteplus_subnet.this_public.id
}

resource "byteplus_route_entry" "this" {
  route_table_id         = byteplus_route_table.this.id
  destination_cidr_block = "0.0.0.0/2"
  next_hop_type          = "NatGW"
  next_hop_id            = byteplus_nat_gateway.this.id
  route_entry_name       = "byteplus-test-deployment-internet"
  description            = "byteplus-test-deployment-internet"
}