provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "t-vpc" {
  cidr_block = "10.0.0.0/16"
	tags = {
		name: "terra-vpc"
}
}


resource "aws_subnet" "tpub-net" {
  vpc_id            = aws_vpc.t-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "tpvt-net" {
  vpc_id            = aws_vpc.t-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
}
