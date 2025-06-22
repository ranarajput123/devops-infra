resource "google_project_iam_custom_role" "full_stack_dev" {
  role_id     = "full_stack_dev"
  title       = "Full Stack Developer Role"
  permissions = local.full_stack_dev_permissions
}

resource "google_project_iam_member" "full_stack_dev" {
  for_each = toset(var.full_stack_devs)
  project  = var.project
  role     = google_project_iam_custom_role.full_stack_dev.id
  member   = "user:${each.value}"
}

resource "google_project_iam_custom_role" "backend_dev" {
  role_id     = "backend_dev"
  title       = "Backend Developer Role"
  permissions = local.backend_dev
}

resource "google_project_iam_member" "backend_dev" {
  for_each = toset(var.backend_devs)
  project  = var.project
  role     = google_project_iam_custom_role.backend_dev.id
  member   = "user:${each.value}"
}

resource "google_project_iam_custom_role" "frontend_dev" {
  role_id     = "frontend_dev"
  title       = "Frontend Developer Role"
  permissions = local.frontend_dev
}

resource "google_project_iam_member" "frontend_dev" {
  for_each = toset(var.frontend_devs)
  project  = var.project
  role     = google_project_iam_custom_role.frontend_dev.id
  member   = "user:${each.value}"
}
