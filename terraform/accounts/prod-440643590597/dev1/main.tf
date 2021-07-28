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
  code_star_connection_arn           = "arn:aws:codestar-connections:us-west-2:440643590597:connection/d467e934-62c9-4097-aacd-b19b32837f05"
  custom_error_response_page_path    = "/errors/404.html"
  domain                             = "dev.ordinaryexperts.com"
  env                                = "dev1"
  notification_email                 = "dylan@ordinaryexperts.com"
  region                             = "us-east-1"
  repo_branch                        = "develop"
  repo_name                          = "ordinaryexperts/website-ordinaryexpertsdotcom"
  whitelisted_ips                    = [ { value = "54.68.77.9/32", type = "IPV4" } ]
}

provider "aws" {
  region  = local.region
  version = "~> 2.0"
}

module "website" {
  source  = "ordinaryexperts/static-website-with-cicd/aws"
  version = "4.1.1"

  cert_arn = local.cert_arn
  code_build_docker_image_identifier = local.code_build_docker_image_identifier
  code_star_connection_arn = local.code_star_connection_arn
  custom_error_response_page_path = local.custom_error_response_page_path
  domain = local.domain
  env = local.env
  notification_email = local.notification_email
  repo_branch = local.repo_branch
  repo_name = local.repo_name
  whitelisted_ips = local.whitelisted_ips
}
