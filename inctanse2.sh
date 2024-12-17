#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -u  # Treat unset variables as an error and exit immediately
set -o pipefail  # Exit if any command in a pipeline fails

# Logging function
log() {
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

log "Starting the EC2 instance creation script."

# Step 1: Fetch the latest Amazon Linux 2 AMI ID
log "Fetching the latest Amazon Linux 2 AMI ID..."
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" \
  "Name=state,Values=available" --query "Images[0].ImageId" --output text) || {
  log "Error retrieving AMI ID."; exit 1;
}
log "Found AMI ID: $AMI_ID"

# Step 2: Create or retrieve an existing Security Group
SECURITY_GROUP_NAME="MyWebAppSG2"
log "Checking if Security Group $SECURITY_GROUP_NAME exists..."
SECURITY_GROUP_ID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=$SECURITY_GROUP_NAME" \
  --query "SecurityGroups[0].GroupId" --output text 2>/dev/null) || true

if [ -z "$SECURITY_GROUP_ID" ]; then
  log "Security Group $SECURITY_GROUP_NAME does not exist. Creating a new one..."
  SECURITY_GROUP_ID=$(aws ec2 create-security-group --group-name "$SECURITY_GROUP_NAME" \
    --description "Security group for web app" --query "GroupId" --output text) || {
    log "Error creating Security Group."; exit 1;
  }
  log "Created Security Group with ID: $SECURITY_GROUP_ID"

  # Allow SSH and HTTP traffic
  log "Adding ingress rules to Security Group..."
  MY_IP=$(curl -s https://checkip.amazonaws.com) || { log "Error retrieving public IP."; exit 1; }
  aws ec2 authorize-security-group-ingress --group-id "$SECURITY_GROUP_ID" \
    --protocol tcp --port 22 --cidr "$MY_IP/32"
  aws ec2 authorize-security-group-ingress --group-id "$SECURITY_GROUP_ID" \
    --protocol tcp --port 80 --cidr 0.0.0.0/0
else
  log "Security Group $SECURITY_GROUP_NAME already exists with ID: $SECURITY_GROUP_ID"
fi

# Step 3: Fetch the default Subnet ID
log "Fetching default Subnet ID..."
SUBNET_ID=$(aws ec2 describe-subnets --filters "Name=default-for-az,Values=true" \
  --query "Subnets[0].SubnetId" --output text) || {
  log "Error retrieving Subnet ID."; exit 1;
}
log "Found Subnet ID: $SUBNET_ID"

# Step 4: Specify or create a key pair
KEY_NAME="MyWebAppKey"
log "Creating Key Pair with name: $KEY_NAME..."
if aws ec2 describe-key-pairs --key-names "$KEY_NAME" &>/dev/null; then
  log "Key Pair $KEY_NAME already exists."
else
  aws ec2 create-key-pair --key-name "$KEY_NAME" --query "KeyMaterial" --output text > "$KEY_NAME.pem"
  chmod 400 "$KEY_NAME.pem"
  log "Created Key Pair and saved to $KEY_NAME.pem"
fi

# Step 5: Launch the EC2 Instance
log "Launching EC2 instance..."
INSTANCE_ID=$(aws ec2 run-instances --image-id "$AMI_ID" --count 1 --instance-type t2.micro \
  --key-name "$KEY_NAME" --security-group-ids "$SECURITY_GROUP_ID" --subnet-id "$SUBNET_ID" \
  --query "Instances[0].InstanceId" --output text) || {
  log "Error launching EC2 instance."; exit 1;
}
log "Launched EC2 instance with ID: $INSTANCE_ID"

# Step 6: Wait for the instance to be running and fetch the Public IP
log "Waiting for the instance to start..."
aws ec2 wait instance-running --instance-ids "$INSTANCE_ID"
PUBLIC_IP=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" \
  --query "Reservations[0].Instances[0].PublicIpAddress" --output text)
log "Instance is running. Public IP: $PUBLIC_IP"

# Final message
log "EC2 instance is ready and accessible at IP: $PUBLIC_IP"
