terraform {
  backend "s3" {
    bucket = "udacity-tf-robinson-west" # Replace it with your S3 bucket name
    key    = "terraform/terraform.tfstate"
    region = "us-west-1"
  }
}

provider "aws" {
  alias  = "east"
  region = "us-east-2"

  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  region = "us-west-1"
  #profile = "default"

  default_tags {
    tags = local.tags
  }
}
