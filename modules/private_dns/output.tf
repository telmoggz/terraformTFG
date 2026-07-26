output "private_dns_zone_id" {
  value       = module.private_dns.private_dns_zone_id
  description = "The ID of the private DNS zone."
}

output "private_dns_zone_name" {
  value       = module.private_dns.private_dns_zone_name
  description = "The name of the private DNS zone."
}