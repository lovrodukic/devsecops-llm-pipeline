from flask import Flask, render_template, request
from dotenv import load_dotenv
import requests
import os

app = Flask(__name__)

load_dotenv()

# API key from environment variables
OPENAI_API_KEY = os.getenv('OPENAI_API_KEY')
OPENAI_URL = 'https://api.openai.com/v1/chat/completions'

# Send a prompt to LLM
def call_llm(prompt):
    headers = {
        'Authorization': f'Bearer {OPENAI_API_KEY}',
        'Content-Type': 'application/json'
    }
    data = {
        "model": "gpt-3.5-turbo",
        "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": prompt}
        ]
    }

    response = requests.post(OPENAI_URL, json=data, headers=headers)
    if response.status_code == 200:
        return response.json()
    else:
        print("Failed Request Response:", response.text) 
        return f"Error: {response.status_code}, Message: {response.text}"

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        user_input = request.form['user_input']
        response = call_llm(user_input)
        return render_template(
            'index.html',
            response=response
        )
    
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)
