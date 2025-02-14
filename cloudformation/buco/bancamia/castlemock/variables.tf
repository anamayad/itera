variable "region" {
   description = "AWS Region"
}


variable "environment" {}

variable "subnet_id_efs_castlemock" {
    description = "Subnet id for efs storage"
   type = string
}

variable "castlemock_controller_cpu" {
   description = "The CPU for the castlemock controller"
   type = number
}

variable "castlemock_controller_mem" {
   description = "The memory for the castlemock controller"
   type = number
}

variable "castlemock_controller_port" {
   description = "The port of the castlemock controller"
   type = number
}


variable "prefix" {
   description = "AWS Resource Prefix"
   type = string
}



variable "tag_name" {
  type        = string
  description = "Etiqueta de nombre"
}

variable "name" {
  type        = string
  description = "Nombre del cluster"
}



variable "ami_ec2"{
  type = string
  description = "identificador del tipo de instancia ami"
  default = "ami-0557a15b87f6559cf"
}

variable "instance_type"{
   type = string
  description = "identificador de carracteristicas de instancia"
  default = "t2.micro"
}

variable "security_groups"{
  type = list(string)
  description = "lista de grupos de seguridad ec2 del cluster"
  default = []
}

variable "desired_capacity"{
  type = number
  description = "cantidad de instancias deseables"
  default = 2
}

variable "min_size"{
  type = number
  description = "cantidad de instancias minima"
  default = 1
}

variable "max_size"{
  type = number
  description = "cantidad de instancias maximas"
  default = 3
}

variable "health_check_grace_period"{
  type = number
  description = "tiempo de espera para revisión de instancias"
  default = 300
}

variable "cluster_exists" {
  type        = bool
  description = "validar existencia de cluster"
  default = false
}

variable "project" {}
