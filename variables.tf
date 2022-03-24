variable "region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "ap-southeast-2"
}

variable "role_name" {
  type        = string
  description = "Name of IAM role to be created"
}

variable "parameter_name" {
  type        = string
  description = "SSM parameter name"
  default     = "EXTERNAL_ID"
}

variable "managed_policy_arns" {
  type        = list(any)
  description = "List of managed policies to attach to the role"
}

variable "iam_username" {
  type        = string
  description = "IAM user to be created"
}
