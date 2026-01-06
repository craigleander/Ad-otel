# Enable required APIs
resource "google_project_service" "apis" {
  for_each = toset([
    "firestore.googleapis.com",
    "secretmanager.googleapis.com",
    "servicenetworking.googleapis.com",
    "sqladmin.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "redis.googleapis.com"
  ])
  
  project = var.project_id
  service = each.key
  
  disable_on_destroy = false
}

module "network" {
  source = "./modules/network"

  project_id   = var.project_id
  network_name = "gke-network"
  subnets = [
    {
      subnet_name   = "gke-subnet"
      subnet_ip     = "10.0.0.0/17"
      subnet_region = var.region
    }
  ]
  secondary_ranges = {
    gke-subnet = [
      {
        range_name    = "ip-range-pods"
        ip_cidr_range = "192.168.0.0/18"
      },
      {
        range_name    = "ip-range-services"
        ip_cidr_range = "192.168.64.0/18"
      },
    ]
  }
}

module "service_accounts" {
  source     = "./modules/service_accounts"
  project_id = var.project_id
  names      = ["gke-node-sa", "app-sa"]
  project_roles = [
    "${var.project_id}=>roles/logging.logWriter",
    "${var.project_id}=>roles/monitoring.metricWriter",
    "${var.project_id}=>roles/monitoring.viewer",
  ]
}

module "gke" {
  source                = "./modules/gke"
  project_id            = var.project_id
  cluster_name          = "main-cluster"
  region                = var.region
  zones                 = ["${var.region}-a", "${var.region}-b"]
  network_name          = module.network.network_name
  subnetwork_name       = module.network.subnets_names[0]
  ip_range_pods         = "ip-range-pods"
  ip_range_services     = "ip-range-services"
  service_account_email = module.service_accounts.email
}

module "sql" {
  source            = "./modules/sql"
  project_id        = var.project_id
  name              = "main-db"
  region            = var.region
  zone              = var.zone
  network_self_link = module.network.network_self_link
  
  # Ensure SQL waits for the private service connection to be established
  depends_on = [module.network]
}

module "bigtable" {
  source     = "./modules/bigtable"
  project_id = var.project_id
  name       = "main-bigtable"
  zones = {
    zone1 = {
      cluster_id = "cluster-a"
      zone       = "${var.region}-a"
      num_nodes  = 1
    }
  }
  tables = {
    table1 = {
      table_name          = "app-table"
      split_keys          = []
      deletion_protection = "UNPROTECTED"
    }
  }
}

module "memorystore" {
  source             = "./modules/memorystore"
  project_id         = var.project_id
  name               = "main-redis"
  region             = var.region
  authorized_network = module.network.network_self_link
}

module "cloud_storage" {
  source     = "./modules/storage"
  project_id = var.project_id
  names      = ["app-assets-${var.project_id}", "app-logs-${var.project_id}"]
  prefix     = ""
  versioning = {
    "app-assets-${var.project_id}" = true
  }
}

module "pubsub" {
  source     = "./modules/pubsub"
  project_id = var.project_id
  topic      = "app-events"
  pull_subscriptions = [
    {
      name = "app-worker-sub"
    }
  ]
}

module "firestore" {
  source      = "./modules/firestore"
  project_id  = var.project_id
  location    = var.region
  database_id = "(default)"
  type        = "FIRESTORE_NATIVE"
  
  depends_on = [google_project_service.apis]
}

module "secret_manager" {
  source     = "./modules/secret_manager"
  project_id = var.project_id
  secrets = [
    {
      name        = "db-password"
      secret_data = "supersecret"
    }
  ]
  
  depends_on = [google_project_service.apis]
}
