resource "google_cloudfunctions_function" "function" {
  provider = google-beta

  name        = var.function_name
  description = var.function_description
  runtime     = "java11"

  available_memory_mb   = var.memory
  source_archive_bucket = var.bucket_name
  source_archive_object = var.bucket_object
  entry_point           = var.entry_point
  trigger_http          = true
  environment_variables = var.env_variables
  timeout               = var.timeout
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  provider       = google-beta
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}
