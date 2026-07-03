variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the vpc"
  type        = string
}

variable "PubSub1CIDR" {
  description = "Public CIDR block for the subnet"
  type        = string
}

variable "PubSub2CIDR" {
  description = "Public CIDR block for the subnet"
  type        = string
}

variable "PrivSub1CIDR" {
  description = "Private CIDR block for the subnet"
  type        = string
}

variable "PrivSub2CIDR" {
  description = "Private CIDR block for the subnet"
  type        = string
}

variable "Zone1" {
  description = "us east 1a zone"
  type        = string
}

variable "AWS_REGION" {
  description = "Rigion of the deployment"
  type        = string
}

variable "key_pair_name" {
  description = "Name of the key pair"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public key"
  type        = string
}

variable "pubsub_1_name" {
  description = "1st public subnet"
  type        = string
}

variable "pubsub_2_name" {
  description = "2nd public subnet"
  type        = string
}

variable "privsub_1_name" {
  description = "1st private subnet"
  type        = string
}

variable "privsub_2_name" {
  description = "2nd private subnet"
  type        = string
}

variable "igw_name" {
  description = "the ingress name"
  type        = string
}

variable "instance_type" {
  description = "using instance"
  type        = string
}

variable "ami_id" {
  description = "using ami id"
  type        = string
}
