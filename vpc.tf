# Virtual Private Cloud
resource "aws_vpc" "vpc-poc" {
  cidr_block = "10.30.0.0/16"
  enable_dns_hostnames = "true"
}
# IP publicas
resource "aws_subnet""pub_subnet"{
  vpc_id = aws_vpc.vpc-poc.id
  cidr_block = "10.30.1.0/24"
}

resource "aws_subnet""pub_subnet2"{
  vpc_id = aws_vpc.vpc-poc.id
  cidr_block = "10.30.2.0/24"
}

# IP privadas
resource "aws_subnet""priv_subnet"{
  vpc_id = aws_vpc.vpc-poc.id
  cidr_block = "10.30.3.0/24"
}

resource "aws_subnet""priv_subnet2"{
  vpc_id = aws_vpc.vpc-poc.id
  cidr_block = "10.30.4.0/24"
}

# internet gateway
resource "aws_internet_gateway" "igw"{
  vpc_id = aws_vpc.vpc-poc.id
}

# rutas no tabla de enrutamiento
# resource "aws_route""route"{
#   route_table_id = aws_vpc.vpc-poc.main_route_table_id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id =aws_internet_gateway.igw.id
# }

# resource "aws_route_table" "rutas" {
#  vpc_id = aws_vpc.vpc-poc.id
 
#  route {
#   cidr_block = "0.0.0.0/0"
#   gateway_id = aws_internet_gateway.igw.id
#   } 
# }


# Security group
resource "aws_security_group""permiso_tls"{
  name = "allow_all"
  description = "permite todo el trafico de entrada y de salida"
  vpc_id = aws_vpc.vpc-poc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regla para permitir todo el tráfico de salida
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# #tablas de rutamiento
resource "aws_route_table" "rutas" {
 vpc_id = aws_vpc.vpc-poc.id
 
 route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
  } 

  route{
    cidr_block = "192.168.0.0/16"
    gateway_id = aws_vpn_gateway.vpn_gw.id
  }
}

resource "aws_route_table_association""a"{
  subnet_id = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.rutas.id
}

resource "aws_route_table_association""b"{
  subnet_id = aws_subnet.priv_subnet.id
  route_table_id = aws_route_table.rutas.id
}

#VPN
resource "aws_customer_gateway" "onpremisegw" {
  bgp_asn    = 65000
  ip_address = "190.219.213.37" #ip publica del Fortinet
  type = "ipsec.1"
}

resource "aws_vpn_gateway" "vpn_gw" {
  vpc_id = aws_vpc.vpc-poc.id
}

resource "aws_vpn_connection" "mivpn" {
  customer_gateway_id  = aws_customer_gateway.onpremisegw.id
  vpn_gateway_id   = aws_vpn_gateway.vpn_gw.id
  # outside_ip_address_type  = "PrivateIpv4" #essto se usa para el transit gateway
  type    = "ipsec.1"
  static_routes_only  = true
  local_ipv4_network_cidr = "10.30.0.0/16"
  remote_ipv4_network_cidr = "192.168.0.0/16" 
}

resource "aws_vpn_connection_route" "staticip"{
  destination_cidr_block = "10.30.0.0/16"
  vpn_connection_id = aws_vpn_connection.mivpn.id
}