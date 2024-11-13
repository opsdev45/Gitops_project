terraform {
  backend "s3" {
    bucket = "terraform-state-file-migdal"
    key    = "statefile"
    region = "eu-west-2"
  }
}
