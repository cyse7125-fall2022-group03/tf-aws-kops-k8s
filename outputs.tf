output "iam_kops_user_arn" {
  value = aws_iam_user.iam_kops.arn
}

output "iam_access_key_id" {
  description = "The access key ID"
  value       = aws_iam_access_key.kops_access_key.id
}

output "mysecret" {
  value = nonsensitive(aws_iam_access_key.kops_access_key.secret)
}


