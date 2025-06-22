output "backend_dev_role_id" {
  value = google_project_iam_custom_role.backend_dev.role_id
}

output "frontend_dev_role_id" {
  value = google_project_iam_custom_role.frontend_dev.role_id
}

output "full_stack_dev_role_id" {
  value = google_project_iam_custom_role.full_stack_dev.role_id
}