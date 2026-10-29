variable "name" {
  type        = string
  description = "Environment name prefix"
}

variable "tags" {
  type        = map(string)
  description = "Common resource tags"
  default     = {}
}