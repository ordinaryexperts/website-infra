terraform {
  backend "s3" {
    bucket  = "oe-prod-tf-state-us-east-1"
    key     = "dev1/terraform.tfstate"
    region  = "us-east-1"
  }
}

locals {
  cert_arn                           = "arn:aws:acm:us-east-1:440643590597:certificate/9e374f6a-3e37-4c9d-9002-907fef541e13"
  code_build_docker_image_identifier = "aws/codebuild/ruby:2.5.3"
  code_commit_repo_branch            = "develop"
  code_commit_repo_name              = "website-ordinaryexpertsdotcom"
  custom_error_response_page_path    = "/errors/404.html"
  domain                             = "dev.ordinaryexperts.com"
  env                                = "dev1"
  notification_email                 = "dylan@ordinaryexperts.com"
  region                             = "us-east-1"
  whitelisted_ips                    = [ { value = "54.68.77.9/32", type = "IPV4" } ]
}

provider "aws" {
  region  = local.region
  version = "~> 2.0"
}

module "website" {
  # source = "../../../../../terraform-aws-static-website-with-cicd"
  source  = "ordinaryexperts/static-website-with-cicd/aws"
  version = "3.0.0"

  cert_arn = local.cert_arn
  code_build_docker_image_identifier = local.code_build_docker_image_identifier
  code_commit_repo_branch = local.code_commit_repo_branch
  code_commit_repo_name = local.code_commit_repo_name
  custom_error_response_page_path = local.custom_error_response_page_path
  domain = local.domain
  env = local.env
  notification_email = local.notification_email
  whitelisted_ips = local.whitelisted_ips
}
