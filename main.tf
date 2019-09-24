terraform {
  required_version = ">= 0.11.0"
}

provider "aws" {
  region = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

resource "aws_instance" "ubuntu" {
  ami               = "${var.ami_id}"
  instance_type     = "${var.instance_type}"
  availability_zone = "${var.aws_region}a"

  tags {
    Name        = "${var.name}"
    TTL         = "${var.ttl}"
    Owner       = "${var.owner}"
    Description = "This is a Customer29 demo description"
  }
}

resource "aws_iam_policy" "policy" {
  name        = "${var.owner}_sentinel_test_policy"
  path        = "/"
  description = "Policy to test Sentinel permissions checks"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:List*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
