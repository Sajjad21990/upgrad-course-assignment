module "terraform_s3_bucket" {
  source  = var.s3_bucket_module_source
  version = var.s3_bucket_module_version

  bucket_name = var.s3_bucket_terraform_name
  acl         = "private"
}