#!/bin/bash

sudo apt update -y
sudo apt install -y python3-pip python3-venv

cd /home/ubuntu/app

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

pip install -r requirements.txt

# Load environment variables
if [ -f .env ]; then
  export $(cat .env | xargs)
fi

# Start Flask app
flask run --host=0.0.0.0 --port=80
