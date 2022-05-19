#Primary VPC
resource aws_vpc main {
    cidr_block           = "172.16.0.0/16"
    instance_tenancy     = "default"
    enable_dns_support   = "true"
    enable_dns_hostnames = "true"
    enable_classiclink   = "false"
    tags = {
        name = "main"
        managed_by = "terraform"
    }
}

#subnets
resource aws_subnet main-public-1 {
    vpc_id                     = aws_vpc.main.id
    cidr_block                 = "172.16.1.0/24"
    map_public_ip_on_launch    = "true"
    availability_zone          = "us-west-2a"
    tags = {
        name = "main-public-1"
        managed_by = "terraform"
    }
}

resource aws_subnet main-private-1 {
    vpc_id                     = aws_vpc.main.id
    cidr_block                 = "172.16.2.0/24"
    map_public_ip_on_launch    = "false"
    availability_zone          = "us-west-2a"
    tags = {
        name = "main-private-1"
        managed_by = "terraform"
    }
}


resource aws_subnet main-public-2 {
    vpc_id                     = aws_vpc.main.id
    cidr_block                 = "172.16.3.0/24"
    map_public_ip_on_launch    = "true"
    availability_zone          = "us-west-2b"
    tags = {
        name = "main-public-2"
        managed_by = "terraform"
    }
}


resource aws_subnet main-private-2 {
    vpc_id                     = aws_vpc.main.id
    cidr_block                 = "172.16.4.0/24"
    map_public_ip_on_launch    = "false"
    availability_zone          = "us-west-2b"
    tags = {
        name = "main-private-2"
        managed_by = "terraform"
    }
}

#Default Gateway
resource aws_internet_gateway main-gw {
    vpc_id = aws_vpc.main.id
    tags = {
        name = "main-gw"
        managed_by = "terraform"
    }
}

#route tables
resource aws_route_table main-public {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-gw.id
    }
    tags = {
        name = "main-public-1"
        managed_by = "terraform"
    }
}

#route associations public
resource aws_route_table_association main-public-1-a {
    subnet_id       = aws_subnet.main-public-1.id
    route_table_id  = aws_route_table.main-public.id
}

resource aws_route_table_association main-public-2a {
    subnet_id       = aws_subnet.main-public-1.id
    route_table_id  = aws_route_table.main-public.id
}
