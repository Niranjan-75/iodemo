provider "aws" {
  region     = "ap-south-1"
  /*access_key = "my-access-key"
  secret_key = "my-secret-key"*/
}

terraform {
 backend "s3"
     encrypt = false
     bucket = "tf-state-s3"
     dynamo_table = "tf-state-lock-dynamo"
     key = "path/path/terraform-tfstate"
     region = "ap-south-1"
}


resource "aws_vpc" "tf_test" {
     cidr_block = "10.0.0.0/16"
     instance_tenancy = "default"
     enable_dns_hostnames = 
     tags = {
         Name = "tf_test"
     }
}

resource "aws_subnet" "subnet-tf-public" {
    vpc_id = aws_vpc.tf_test.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      "Name" = "subnet-tf-public"
    }
  
}

resource "aws_subnet" "subnet-tf-private" {
    vpc_id = aws_vpc.tf_test.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-south-1b"
    tags = {
      "Name" = "subnet-tf-private"
    }
  
}




