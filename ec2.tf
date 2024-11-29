# Instancia
resource "aws_instance" "mi_instancia_ec2"{
  ami = "ami-0866a3c8686eaeeba" # ubuntu
  instance_type = "t2.micro"
  key_name = aws_key_pair.mi_llave_rsa.key_name
  subnet_id = aws_subnet.pub_subnet.id
  security_groups = [aws_security_group.permiso_tls.id]
  associate_public_ip_address = true 
}

# llave de acceso
resource "aws_key_pair" "mi_llave_rsa"{
  key_name = "llave_rsa"
  public_key = tls_private_key.mi_llave.public_key_openssh
}

resource "tls_private_key" "mi_llave"{
  algorithm = "RSA"
  rsa_bits = 2048
}

output "private_key_pem" {
  value     = tls_private_key.mi_llave.private_key_pem
  sensitive = true
}

resource "local_file" "private_key" {
  content  = tls_private_key.mi_llave.private_key_pem
  filename = "${path.module}/my-key-pair.pem"
}

