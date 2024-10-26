# DevSecOps Secure CI/CD/LLM Workflow

This project is a **DevSecOps (Development, Security, and Operations) pipeline**
designed to integrate a Large Language Model (LLM) for enhanced security checks.
The pipeline automates infrastructure deployment using Infrastructure as Code
(IaC) principles and incorporates AI to identify and mitigate security risks
before deployment.

## To Do:
- Deploy `app` and add CI/CD actions for deployment.
- Separate `app` and `terraform` CI/CD actions. Only trigger each action upon
  update to corresponding directory.
- Incorporate LLM trigger for scanning security vulnerabilities and code review.

## Technologies
- **Infrastructure**: AWS, Terraform
- **Generative AI**: LLMs, including OpenAI models and WhiteRabbitNeo
- **Languages**: Python
