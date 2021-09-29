variable "access_key" {
  description = "The AWS access key, required in order to deploy resources on Amazon Web Services"
  type        = string
}

variable "secret_key" {
  description = "The AWS secret key, required in order to deploy resources on Amazon Web Services"
  type        = string
}

variable "ssh_key_name" {
  description = "The name of the AWS key pair used to connect via SSH to Amazon Web Services"
  type        = string
}

variable "ssh_key_location" {
  description = "The filelocation of the AWS key pair used to connect via SSH to Amazon Web Services"
  type        = string
}