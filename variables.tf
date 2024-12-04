# Credenciales para acceder a aws

variable "AWS_ACCESS_KEY_ID"{
    description = "llave de acceso"
    type = string
    sensitive = true 
}

variable "AWS_SECRET_KEY_ID"{
    description = "llave de acceso"
    type = string
    sensitive = true
} 

