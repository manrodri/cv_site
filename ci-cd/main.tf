resource "aws_iam_role" "example" {
  name = "example"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "example" {
  role = aws_iam_role.example.name

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
                "cloudfront:*"
            ],
      "Resource": "*"
    },

    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
POLICY
}

resource "aws_codebuild_project" "example" {
  name          = "test-project"
  description   = "test_codebuild_project"
  build_timeout = "5"
  service_role  = aws_iam_role.example.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "WWW_BUCKET"
      value = var.bucket_name
    }
    environment_variable {
      name  = "WWW_CLOUDFRONT_DIST_ID"
      value = var.www_cloudfront_id
    }
    environment_variable {
      name  = "ROOT_CLOUDFRONT_DIST_ID"
      value = var.root_cloudfront_id
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/manrodri/cv_site.git"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = "master"


  tags = local.common_tags
}

resource "aws_codebuild_webhook" "example" {
  project_name = aws_codebuild_project.example.name
  build_type   = "BUILD"
  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }

    filter {
      type    = "HEAD_REF"
      pattern = "master"
    }
  }
}