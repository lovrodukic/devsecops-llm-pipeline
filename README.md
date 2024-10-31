# DevSecOps Secure CI/CD/LLM Workflow

This project is a **DevSecOps (Development, Security, and Operations) pipeline**
designed to integrate a Large Language Model (LLM) for enhanced security checks.
The pipeline automates infrastructure deployment using Infrastructure as Code
(IaC) principles and incorporates AI to identify and mitigate security risks
before deployment.

## Structure:
- `.github/workflows`: All `.yml` files defining GitHub actions workflows.
  - `app.yml`: Deploys the app to an EC2 instance.
  - `scan.yml`: Runs a vulnerability scan whenever files in the `app/` directory
    are updated.
  - `terraform.yml`: Deploys or updates infrastructure when files in the
    `terraform/` directory (IaC) are modified.
  
- `app/`: A generic Flask app of a simple implementation of a GPT-wrapper chatbot
  to demonstrate functionality of vulnerability scan.
  
- `sample/`: Contains a sample output of `vulnerability_report.md`, which is
  typically generated and stored as an artifact in GitHub Actions.

- `scripts/`: Contains scripts invoked by `.yml` files. 

- `terraform/`: Contains `.tf` files defining infrastructure as code (IaC) to
  provision resources for hosting the application.

## Technologies
- **Infrastructure**: AWS, Terraform
- **Generative AI**: LLMs, OpenAI API
- **Languages**: Python, HCL

## Usage
1. **Set up GitHub Secrets**: Ensure required secrets and credentials are
  configured in GitHub for CI/CD and vulnerability scanning.
2. **Deployment**:
  - Any changes to `terraform/` will automatically trigger the
    CI/CD workflow for the IaC.
  - Any changes to `app/` will automatically trigger the CI/CD workflow to scan
    for vulnerabilities.
  - Developers may review the artifact in GitHub actions, review the application
    code, and then decide whether or not to trigger the deployment pipeline.
3. **Sample Output**: Review the `sample/vulnerability_report.md` for an example
  of the vulnerability scan report.
