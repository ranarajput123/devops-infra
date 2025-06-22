resource "google_project_iam_custom_role" "full_stack_dev" {
  count = length(var.full_stack_devs) > 0 ? 1 : 0

  role_id     = "full_stack_dev"
  title       = "Full Stack Developer Role"
  permissions = local.full_stack_dev_permissions
}

resource "google_project_iam_member" "full_stack_dev" {
  for_each = length(var.full_stack_devs) > 0 ? toset(var.full_stack_devs) : toset([])

  project  = var.project
  role     = google_project_iam_custom_role.full_stack_dev[0].id
  member   = "user:${each.value}"
}

resource "google_project_iam_custom_role" "backend_dev" {
  count = length(var.backend_devs) > 0 ? 1 : 0

  role_id     = "backend_dev"
  title       = "Backend Developer Role"
  permissions = local.backend_dev
}

resource "google_project_iam_member" "backend_dev" {
  for_each = length(var.backend_devs) > 0 ? toset(var.backend_devs) : toset([])
  
  project  = var.project
  role     = google_project_iam_custom_role.backend_dev[0].id
  member   = "user:${each.value}"
}

resource "google_project_iam_custom_role" "frontend_dev" {
  count = length(var.frontend_devs) > 0 ? 1 : 0

  role_id     = "frontend_dev"
  title       = "Frontend Developer Role"
  permissions = local.frontend_dev
}

resource "google_project_iam_member" "frontend_dev" {
  for_each = length(var.frontend_devs) > 0 ? toset(var.frontend_devs) : toset([])

  project  = var.project
  role     = google_project_iam_custom_role.frontend_dev[0].id
  member   = "user:${each.value}"
}
