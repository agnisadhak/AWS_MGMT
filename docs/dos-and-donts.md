# Do’s and Don’ts

Best practices and guidelines for managing AWS infrastructure in this project.

## ✅ Do's

### Infrastructure as Code
- **Run `terraform plan` first**: Always review changes before applying them with `terraform apply`.
- **Use meaningful names**: Name your EC2 instances, S3 buckets, and RDS instances descriptively.
- **VCS for configurations**: Commit all `.tf` files to Git.
- **Use Variables**: Keep configurations reusable by using `variables.tf`.

### Cost Management
- **Run weekly cost checks**: Use `check-aws-costs.ps1` at least once a week to spot trends.
- **Review anomaly reports**: Pay attention to "Optimization Review" documents.
- **Use Tags**: Tag every resource created by Terraform to make cost tracking easier.

### Security
- **Use IAM Roles**: Prefer IAM roles over long-term access keys where possible.
- **Check the `.gitignore`**: Ensure `terraform.tfstate` and secrets are never tracked.
- **Use `--dry-run`**: When using the CLI for destructive actions, use the dry-run flag where available.

---

## ⛔ Don'ts

### Infrastructure
- **Manual Console Edits**: Never modify resources directly in the AWS Console if they are managed by Terraform (avoids "Configuration Drift").
- **Hard-coding Names**: Avoid hard-coding ARNs or IDs; use Data Sources (`data.tf`) instead.
- **Shadow IT**: Don't create resources outside of the established management scope.

### Cost Management
- **Leave Test Instances Running**: Always stop or terminate instances created for testing (`setup-rds-auto-stop.ps1` helps with this).
- **Ignore High Spikes**: Never let a cost spike go uninvestigated.

### Security
- **Commit Credentials**: NEVER upload AWS Access Keys or Secret Keys to Git.
- **Shared Credentials**: Don't share `~/.aws/credentials` between team members.
- **Commit TFState**: Do not commit `terraform.tfstate` files as they can contain sensitive data (passwords, etc.).
