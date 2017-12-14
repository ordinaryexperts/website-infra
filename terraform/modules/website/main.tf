variable "code_commit_repo_arn" {}
variable "cert_arn" {}
variable "env" {}
variable "url" {}

resource "aws_cloudformation_stack" "website_bucket_and_cf" {
  name = "${var.env}-website-bucket-and-cf-stack"
  on_failure = "DELETE"
  parameters {
    CertificateArn = "${var.cert_arn}"
    Url = "${var.url}"
  }
  template_body = "${file("${path.module}/website_bucket_and_cf.yaml")}"
}

resource "aws_cloudformation_stack" "pipeline_bucket" {
  name = "${var.env}-website-pipeline-bucket-stack"
  on_failure = "DELETE"
  template_body = "${file("${path.module}/pipeline_bucket.yaml")}"
}

resource "aws_cloudformation_stack" "website_cicd" {
  capabilities = ["CAPABILITY_IAM"]
  name = "${var.env}-website-cicd-stack"
  on_failure = "DELETE"
  parameters {
    PipelineBucket = "${aws_cloudformation_stack.pipeline_bucket.outputs["PipelineBucket"]}"
    SourceCodeCommitRepoArn = "${var.url}"
  }
  template_body = "${file("${path.module}/website_cicd.yaml")}"
}
