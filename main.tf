module "vpc" {
  source = "./modules/vpc"

  project_id                      = var.project_id
  network_name                    = var.network_name
  auto_create_subnetworks         = var.auto_create_subnetworks
  routing_mode                    = var.routing_mode
  description                     = var.description
  delete_default_routes_on_create = var.delete_default_routes_on_create
}

module "subnets" {
  source           = "./modules/subnets"
  project_id       = var.project_id
  network_name     = module.vpc.network_name
  subnets          = var.subnets
  secondary_ranges = var.secondary_ranges
}

module "routes" {
  source            = "./modules/routes"
  project_id        = var.project_id
  network_name      = module.vpc.network_name
  routes            = var.routes
  module_depends_on = [module.subnets.subnets]
}


# # Allow Private Networks in attached service projects
# resource "google_compute_global_address" "private_ip_alloc" {
#   name          = "private-ip-alloc"
#   purpose       = "VPC_PEERING"
#   address_type  = "INTERNAL"
#   prefix_length = 16
#   network       = module.vpc.network_self_link
# }
# resource "google_service_networking_connection" "servicenetworking" {
#   network                 = module.vpc.network_self_link
#   service                 = "servicenetworking.googleapis.com"
#   reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
# }