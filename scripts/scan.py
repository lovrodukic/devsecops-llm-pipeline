from dotenv import load_dotenv
import requests
import os

load_dotenv()

# API key from environment variables
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
OPENAI_URL = "https://api.openai.com/v1/chat/completions"

prompt = (
    "You are a security analyst. Analyze the provided code for security "
    "vulnerabilities and provide the results in .md format strictly "
    "using the following template:\n\n"
    "For each vulnerability, include the following sections:\n\n"
    "- **Vulnerability Title**\n"
    "  - **Description**: Brief description of the vulnerability.\n"
    "  - **Impact**: Explain the potential impact.\n"
    "  - **Recommendation**: Suggested fix or mitigation.\n\n"
    "Focus on high-priority issues and be concise. Do not exceed 80 "
    "characters per line; if the description exceeds 80 characters, use a "
    "new line.\n\n"
    "**Example:**\n"
    "- **SQL Injection**:\n"
    "  - **Description**: Code is vulnerable to SQL injection in login().\n"
    "  - **Impact**: Allows attackers to modify queries, risks data exposure.\n"
    "  - **Recommendation**: Use parameterized queries to prevent injection."
)

# Call LLM to scan for vulnerabilities in a file
def llm_scan(content):
    headers = {
        "Authorization": f"Bearer {OPENAI_API_KEY}",
        "Content-Type": "application/json"
    }
    data = {
        "model": "gpt-3.5-turbo",
        "messages": [
            {"role": "system", "content": prompt},
            {"role": "user", "content": content}
        ]
    }

    response = requests.post(OPENAI_URL, json=data, headers=headers)
    if response.status_code == 200:
        return response.json()["choices"][0]["message"]["content"]
    else:
        error_message = response.json()["error"]["message"]
        print(f"Failed Request Response: {error_message}")
        return f"Error: {response.status_code}, Message: {error_message}"

# Obtain file contents from a single file
def scan_file(file_path):
    with open(file_path, "r") as file:
        file_content = file.read()

    return llm_scan(file_content)

# Create report for vulnerability scan and save it as .md
def generate_report():
    report = ["# Vulnerability Report\n"]

    for root, _, files in os.walk("../app"):
        for file in files:
            if file in [".gitignore", ".env"]:
                continue
            file_path = os.path.join(root, file)
            print(f"Scanning {file_path}...")
            vulnerabilities = scan_file(file_path)

            report.append(f"## {file_path}\n")
            report.append(vulnerabilities)
            report.append("\n")
    
    report_path = "vulnerability_report.md"
    with open(report_path, "w") as file:
        file.write("\n".join(report))
    
    print(f"Vulnerability report generated at {report_path}")
        

if __name__ == "__main__":
    generate_report()
