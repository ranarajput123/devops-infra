data "github_repository" "gitops" {
  full_name = "${var.github_owner}/${var.gitops_repo_name}"
}