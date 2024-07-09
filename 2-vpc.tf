# Nothing stops you from using the existing VPC to create a Kubernetes cluster, but I will create all the 
#infrastructure using Terraform for this lesson. For example, instead of resource, you can use data keyword to 
#import it to Terraform. Before creating VPC in a new GCP project, you need to enable compute API. 
#To create a GKE cluster, you also need to enable container google API.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
resource "google_compute_network" "main" {
  name                            = "main"
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
  mtu                             = 1460
  delete_default_routes_on_create = false

  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}
