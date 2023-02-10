# variable "domain_name" {
#   type        = string
#   description = "The domain name for the website."

# }

# variable "bucket_name" {
#   type        = string
#   description = "The name of the bucket without the www. prefix. Normally domain_name."
# }

# variable "common_tags" {
#   description = "Common tags you want applied to all components."
# }



#variables for this project

variable "bucket_name" {
    default = "sinemozturksumus.com"
    type = string
    description = "the bucketname of the website"
    
}

variable "common_tags" {
    default = "by sina"
    type = string
    description = "the tags for this projects"
   
}

variable "domain_name" {
    type = string
    description = "this is your domain name"
    default = "wwww.sinemozturksumus.com"
}