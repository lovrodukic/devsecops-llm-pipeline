import time
import requests
import os

# API key from environment variables
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
OPENAI_URL = "https://api.openai.com/v1/chat/completions"

prompt = (
    "You are a security analyst. Analyze the provided code for security "
    "vulnerabilities and provide the results in Markdown format strictly "
    "using the following template:\n\n"
    "For each vulnerability, include the following sections:\n\n"
    "- **Vulnerability Title**\n"
    "  - **Description**: Brief description of the vulnerability.\n"
    "  - **Impact**: Explain the potential impact.\n"
    "  - **Recommendation**: Suggested fix or mitigation.\n\n"
    "Focus on high-priority issues and be concise. Limit lines to 80 "
    "characters; if necessary, use multiple lines.\n\n"
    "**Example:**\n"
    "- **SQL Injection**:\n"
    "  - **Description**: Code is vulnerable to SQL injection in login().\n"
    "  - **Impact**: Allows attackers to modify queries, risks data exposure.\n"
    "  - **Recommendation**: Use parameterized queries to prevent injection."
)

# Call LLM to scan for vulnerabilities in a file
def llm_scan(file_content):
    headers = {
        "Authorization": f"Bearer {OPENAI_API_KEY}",
        "Content-Type": "application/json"
    }
    data = {
        "model": "gpt-4o-mini",
        "messages": [
            {"role": "system", "content": prompt},
            {"role": "user", "content": file_content}
        ]
    }

    retry_attempts = 3
    for attempt in range(retry_attempts):
        response = requests.post(OPENAI_URL, json=data, headers=headers)
        if response.status_code == 200:
            return response.json()["choices"][0]["message"]["content"]
        elif response.status_code == 429:
            wait_time = (2 ** attempt) * 2
            print(f"Rate limit hit. Retrying in {wait_time} seconds...")
            time.sleep(wait_time)
        else:
            error_message = response.json()["error"]["message"]
            error = f"Error {response.status_code}, Message: {error_message}"
            print(error)

            return error
    
    return "Exceeded retry attempts. Rate limit or quota issue."

# Obtain file contents from a single file
def scan_file(file_path):
    with open(file_path, "r") as file:
        file_content = file.read()

    return llm_scan(file_content)

# Create report for vulnerability scan and save it as .md
def generate_report():
    report = ["# Vulnerability Report\n"]
    report_path = "vulnerability_report.md"

    for root, _, files in os.walk("../app"):
        for file in files:
            if file in [".gitignore", ".env"]:
                continue

            file_path = os.path.join(root, file)
            print(f"Scanning {file_path}...")

            vulnerabilities = scan_file(file_path)
            file_name = file_path.split("/")[-1]
            report.append(f"## {file_name}\n")
            report.append(vulnerabilities)
            report.append("\n")

    with open(report_path, "w") as file:
        file.write("\n".join(report))
    
    print(f"Vulnerability report generated at {report_path}")
        

if __name__ == "__main__":
    generate_report()
