terraform {
  required_providers {
    byteplus = {
      source  = "byteplus-sdk/byteplus"
      version = "0.0.4"
    }
  }
}

provider "byteplus" {
  access_key    = var.access_key
  secret_key    = var.secret_key
  session_token = "sessionToken"
  region        = var.region
}
