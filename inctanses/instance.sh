#!/bin/bash
 
# Step 1: Fetch the latest Amazon Linux 2 AMI ID
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" \
  "Name=state,Values=available" --query "Images[0].ImageId" --output text)
 
# Step 2: Create a new Security Group
SECURITY_GROUP_ID=$(aws ec2 create-security-group --group-name MyWebAppSG2 \
  --description "Security group for web app" --query "GroupId" --output text)
 
# Allow SSH and HTTP traffic
aws ec2 authorize-security-group-ingress --group-id "$SECURITY_GROUP_ID" \
  --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id "$SECURITY_GROUP_ID" \
  --protocol tcp --port 80 --cidr 0.0.0.0/0
 
# Step 3: Fetch the default Subnet ID
SUBNET_ID=$(aws ec2 describe-subnets --filters "Name=default-for-az,Values=true" \
  --query "Subnets[0].SubnetId" --output text)
 
# Step 4: Specify or create a key pair
KEY_NAME="MyWebAppKey"
aws ec2 create-key-pair --key-name "$KEY_NAME" --query "KeyMaterial" --output text > "$KEY_NAME.pem"
chmod 400 "$KEY_NAME.pem"
 
# Step 5: Launch the EC2 Instance
INSTANCE_ID=$(aws ec2 run-instances --image-id "$AMI_ID" --count 1 --instance-type t2.micro \
  --key-name "$KEY_NAME" --security-group-ids "$SECURITY_GROUP_ID" --subnet-id "$SUBNET_ID" \
  --query "Instances[0].InstanceId" --output text)
 
echo "Launched EC2 Instance: $INSTANCE_ID"
 
# Step 6: Wait for the instance to be running and fetch the Public IP
echo "Waiting for the instance to start..."
aws ec2 wait instance-running --instance-ids "$INSTANCE_ID"
PUBLIC_IP=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" \
  --query "Reservations[0].Instances[0].PublicIpAddress" --output text)
 
echo "Instance is running. Public IP: $PUBLIC_IP"