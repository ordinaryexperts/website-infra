terraform {
  backend "s3" {
    bucket  = "oe-prod-tf-state-us-east-1"
    key     = "prod1/terraform.tfstate"
    region  = "us-east-1"
  }
}

locals {
  cert_arn                           = "arn:aws:acm:us-east-1:440643590597:certificate/09a18550-542e-4591-bfbb-e35be2befd7c"
  code_build_docker_image_identifier = "aws/codebuild/ruby:2.5.3"
  code_commit_repo_branch            = "master"
  code_commit_repo_name              = "website-ordinaryexpertsdotcom"
  custom_error_response_page_path    = "/errors/404.html"
  domain                             = "ordinaryexperts.com"
  env                                = "prod1"
  notification_email                 = "dylan@ordinaryexperts.com"
  region                             = "us-east-1"
}

provider "aws" {
  region  = local.region
  version = "~> 2.0"
}

module "website" {
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
}
