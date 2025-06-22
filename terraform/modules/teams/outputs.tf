output "backend_dev_role_id" {
  value = length(google_project_iam_custom_role.backend_dev) > 0 ? google_project_iam_custom_role.backend_dev[0].role_id : null
}

output "frontend_dev_role_id" {
  value = length(google_project_iam_custom_role.frontend_dev) > 0 ? google_project_iam_custom_role.frontend_dev[0].role_id : null
}

output "full_stack_dev_role_id" {
  value = length(google_project_iam_custom_role.full_stack_dev) > 0 ? google_project_iam_custom_role.full_stack_dev[0].role_id : null
}
