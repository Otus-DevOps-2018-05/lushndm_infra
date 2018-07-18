variable public_key_path {
  description = "Path to the public key used for ssh access"
  default     = "~/.ssh/appuser.pub"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable app_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-app-base"
}
