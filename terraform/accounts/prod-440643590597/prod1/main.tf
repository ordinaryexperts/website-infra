terraform {
  backend "s3" {
    bucket  = "oe-prod-tf-state-us-west-2"
    key     = "prod1/terraform.tfstate"
    region  = "us-west-2"
    profile = "oe-prod-us-west-2"
  }
}

variable "profile" {}
variable "region" {}

provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
  version = "~> 0.1"
}
