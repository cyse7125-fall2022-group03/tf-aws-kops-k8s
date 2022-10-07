provider "aws" {
  region  = var.region
  profile = var.profile
}

resource "aws_iam_user" "iam_kops" {
  name = var.username
}


resource "aws_iam_access_key" "kops_access_key" {
  user = aws_iam_user.iam_kops.name
}


resource "aws_iam_user_policy_attachment" "kops-policy-AmazonRoute53FullAccess" {
  user       = aws_iam_user.iam_kops.name
  policy_arn = aws_iam_policy.amazon53FullAccess.arn
}

resource "aws_iam_user_policy_attachment" "kops-policy-AmazonEC2FullAccess" {
  user       = aws_iam_user.iam_kops.name
  policy_arn = aws_iam_policy.amazonEC2FullAccess.arn
}

resource "aws_iam_user_policy_attachment" "kops-policy-IAMFullAccess" {
  user       = aws_iam_user.iam_kops.name
  policy_arn = aws_iam_policy.IAMFullAccess.arn
}

resource "aws_iam_user_policy_attachment" "kops-policy-AmazonSQSFullAccess" {
  user       = aws_iam_user.iam_kops.name
  policy_arn = aws_iam_policy.amazonSQSFullAccess.arn
}

resource "aws_iam_user_policy_attachment" "kops-policy-AmazonS3FullAccess" {
  user       = aws_iam_user.iam_kops.name
  policy_arn = aws_iam_policy.amazonS3FullAccess.arn
}

resource "aws_iam_user_policy_attachment" "kops-policy-amazonVPCFullAccess" {
  user       = aws_iam_user.iam_kops.name
  policy_arn = aws_iam_policy.amazonVPCFullAccess.arn
}

resource "aws_iam_user_policy_attachment" "kops-policy-amazonEventBridgeFullAccess" {
  user       = aws_iam_user.iam_kops.name
  policy_arn = aws_iam_policy.amazonEventBridgeFullAccess.arn
}


resource "aws_s3_bucket" "kops_bucket" {
  bucket = var.s3_bucket_name
  
  tags = {
    Name        = "kOps Bucket"
    Environment = "root"
  }
}

resource "aws_s3_bucket_acl" "kops_bucket_acl" {
  bucket = aws_s3_bucket.kops_bucket.id
  acl    = "private"
}


resource "null_resource" "enable_service_usage_api" {
  provisioner "local-exec" {
    command =  " aws configure set aws_access_key_id ${aws_iam_access_key.kops_access_key.id} --profile kops"
  }
provisioner "local-exec" {
    command =  " aws configure set aws_secret_access_key ${aws_iam_access_key.kops_access_key.secret} --profile kops"
  }

  provisioner "local-exec" {
    command =  " aws configure set region us-east-1 --profile kops"
  }
provisioner "local-exec" {
    command =  "export AWS_PROFILE=kops"
  }

}