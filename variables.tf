variable "username" {
  type        = string
  default     = "kops"
  description = "IAM username for kOps"
}

variable "profile" {
  type        = string
  default     = "ghactions"
  description = "Git profile to be used for running the script"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region to be used"
}


variable "s3_bucket_name" {
  type        = string
  default     = "ketki-csye7125-team3"
  description = "Name of the s3 bucket to be created for kOps"
}