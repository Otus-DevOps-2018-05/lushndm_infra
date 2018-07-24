terraform {
  backend "gcs" {
    bucket = "storage-bucket-lush"
    prefix = "terraform/tfstate/stage"
  }
}
