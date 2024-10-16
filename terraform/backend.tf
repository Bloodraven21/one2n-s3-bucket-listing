terraform {
  backend "s3" {
    bucket         = "one2ntask-tf-remote-state"
    key            = "terraform.tfstate"                # Path within the bucket
    region         = "ap-south-1"                        # Change to your desired region
    dynamodb_table = "one2ntask-lock-dynamodb-table"
    encrypt        = true                                # Enable server-side encryption
  }
}