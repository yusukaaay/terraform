provider "aws" {
  region = "ap-northeast-1"
  version = "2.20"

  # AWS CLI configのprofile(~/.aws/config)
  profile = "stg-cicd-cross-accounts"
}

terraform {

  # ステートバケット
  backend "s3" {
    bucket = "stg-tfstate-terraform-{アカウントID}"
    key    = "service1/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

module "vpc" {
  source  = "../../vpc"

  env = "${var.env}"
}

module "elasticache" {
  source  = "../../elasticache"

  private-subnet01id = "${module.vpc.private-subnet01}"
  private-subnet02id = "${module.vpc.private-subnet02}"
}
