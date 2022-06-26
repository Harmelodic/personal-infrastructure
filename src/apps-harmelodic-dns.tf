variable "apps_harmelodic_dns_name" {
  description = "Harmelodic domain name used for this environment"
  sensitive   = true
  type        = string
}

resource "google_dns_managed_zone" "harmelodic_com" {
  depends_on = [
    google_project_service.host_apis
  ]

  description = "Managed Zone for ${var.apps_harmelodic_dns_name}"
  dns_name    = "${var.apps_harmelodic_dns_name}."
  name        = replace(var.apps_harmelodic_dns_name, ".", "-")
  project     = google_project.host.project_id

  labels = {
    environment = terraform.workspace
  }
}

resource "google_dns_record_set" "harmelodic_com_a" {
  managed_zone = google_dns_managed_zone.harmelodic_com.id
  name         = var.apps_harmelodic_dns_name
  type         = "A"

  rrdatas = [
    "216.239.32.21",
    "216.239.34.21",
    "216.239.36.21",
    "216.239.38.21"
  ]
}

resource "google_dns_record_set" "harmelodic_com_aaaa" {
  managed_zone = google_dns_managed_zone.harmelodic_com.id
  name         = var.apps_harmelodic_dns_name
  type         = "AAAA"

  rrdatas = [
    "2001:4860:4802:32::15",
    "2001:4860:4802:34::15",
    "2001:4860:4802:36::15",
    "2001:4860:4802:38::15"
  ]
}

resource "google_dns_record_set" "harmelodic_com_mx" {
  managed_zone = google_dns_managed_zone.harmelodic_com.id
  name         = var.apps_harmelodic_dns_name
  type         = "MX"

  rrdatas = [
    "1 aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com.",
    "10 alt3.aspmx.l.google.com.",
    "10 alt4.aspmx.l.google.com."
  ]
}

resource "google_dns_record_set" "harmelodic_com_txt" {
  managed_zone = google_dns_managed_zone.harmelodic_com.id
  name = var.apps_harmelodic_dns_name
  type = "TXT"
  rrdatas = [
    "google-site-verification=jXVba9WLVzprbkW4EpS3vtWL5-2YH03AwSc8sprMfSU",
    "keybase-site-verification=sDm605nNkmQuRsuciUxr9KmDkMgBVUKD5Ea38C_8L4w"
  ]
}
