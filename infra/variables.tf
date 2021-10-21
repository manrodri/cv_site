variable "profile" {

}

variable "region" {

}

variable "common_tags" {
  type = map(string)


}

variable "consul_address" {
  type        = string
  description = "Address of the Consul server"
  default     = "127.0.0.1"
}

variable "consul_port" {
  type        = number
  description = "Port Consul is running"
  default     = 8500
}

variable "consul_datacenter" {
  type        = string
  description = "Consul dc"
  default     = "dc1"
}


