terraform {
 backend "s3" {
   bucket  = "terraform-myname" #replace here with your bucket name
   key     = "alb/terraform.state"
   region  = "eu-north-1"
   encrypt = true
 }
}