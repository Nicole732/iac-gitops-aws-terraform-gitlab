variable "aws_region" {
  type    = string
  default = ""
}

variable "aws_profile" {
  type    = string
  default = ""
}

variable "env_prefix" {
  type    = string
  default = ""
}

variable "aws_access_key_id" {
  default = ""
}

variable "aws_secret_access_key" {
  default = ""
}

variable "runner_registration_token" {
  default = ""
  # will not be displayed in tf output
  sensitive = true
}