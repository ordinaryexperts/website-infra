terraform {
  backend "s3" {
    bucket  = "oe-prod-tf-state-us-west-2"
    key     = "dev1/terraform.tfstate"
    region  = "us-west-2"
    profile = "oe-prod-us-west-2"
  }
}

variable "cert_arn" {}
variable "code_commit_repo_arn" {}
variable "env" {}
variable "profile" {}
variable "region" {}
variable "url" {}

provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
  version = "~> 0.1"
}

module "website" {
  source = "../../../modules/website"
  cert_arn = "${var.cert_arn}"
  code_commit_repo_arn = "${var.code_commit_repo_arn}"
  env = "${var.env}"
  url = "${var.url}"
}
