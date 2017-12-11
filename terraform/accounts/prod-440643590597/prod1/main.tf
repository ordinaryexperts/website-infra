terraform {
  backend "s3" {
    bucket  = "oe-prod-tf-state-us-west-2"
    key     = "prod1/terraform.tfstate"
    region  = "us-west-2"
    profile = "oe-prod-us-west-2"
  }
}

variable "env" {}
variable "profile" {}
variable "region" {}

provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
  version = "~> 0.1"
}

module "website" {
  source = "../../../modules/website"
  env = "${var.env}"
  url = "ordinaryexperts.com"
}
