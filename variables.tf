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
  default     = "csye7125-team3"
  description = "Name of the s3 bucket to be created for kOps"
}

variable "pgp_key" {
  type        = string
  default     = ""
  description = "Either a base-64 encoded PGP public key, or a keybase username in the form keybase:some_person_that_exists."
  sensitive   = true
}

variable "status" {
  type        = string
  default     = "Active"
  description = "The access key status to apply. Defaults to Active. Valid values are Active and Inactive."
}


variable "iam_policy_arn" {
  description = "IAM Policy to be attached to role"
  type        = list(string)
  default = ["arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
  "arn:aws:iam::aws:policy/AmazonS3FullAccess"]
}
