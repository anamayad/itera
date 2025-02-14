terraform {
     required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "4.54.0"
      }
    }

     backend "s3" {
    bucket         	   = "backend-tfstate-castle-mock"
    key                = "castlemock.tfstate"
    region         	   = "us-east-1"
    encrypt        	   = true
   
  }
}

 

provider "aws" {
    region = "${var.region}"
  
}