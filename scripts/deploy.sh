#!/bin/bash

# Connection details from environment variables
EC2_USER=${EC2_USER}
EC2_HOST=${EC2_HOST}
SSH_KEY_PATH="$HOME/.ssh/temp-ec2-key.pem"
REMOTE_APP_PATH="/home/ubuntu/app"

# Create SSH private key file
echo "$SSH_PRIVATE_KEY" > $SSH_KEY_PATH
chmod 600 $SSH_KEY_PATH

# Copy application files to the EC2 instance
echo "Copying application files to EC2..."
scp -o StrictHostKeyChecking=no -i "$SSH_KEY_PATH" -r ../app/* ../app/.env \
  "$EC2_USER@$EC2_HOST:$REMOTE_APP_PATH"

# Deploy application to the EC2 instance
echo "Deploying application to EC2..."
ssh -o StrictHostKeyChecking=no -i "$SSH_KEY_PATH" "$EC2_USER@$EC2_HOST" << EOF
  echo "Updating system packages..."
  sudo apt update -y

  echo "Installing dependencies..."
  sudo apt install -y python3-pip python3-venv

  echo "Setting up application directory and virtual environment..."
  sudo mkdir -p $REMOTE_APP_PATH
  cd $REMOTE_APP_PATH || exit
  python3 -m venv venv
  source venv/bin/activate

  echo "Upgrading pip and installing required packages..."
  pip install --upgrade pip setuptools wheel
  pip install -r requirements.txt

  echo "Killing any existing Flask processes..."
  pkill -f 'flask run'

  echo "Starting Flask application with nohup on port 8080..."
  nohup ./venv/bin/flask run --host=0.0.0.0 --port=8080 > nohup.out 2>&1 &
EOF

echo "Deployment complete."

rm -f $SSH_KEY_PATH
