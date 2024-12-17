#!/bin/bash
# Check if an argument was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <script_name>"
  exit 1
fi

# Get the script name from the argument
SCRIPT_NAME="$1"

# Create the new script file with the name passed as argument
echo "#!/bin/bash" > "$SCRIPT_NAME"

# Set executable permissions for the new script
chmod +x "$SCRIPT_NAME"

# Notify the user
echo "Script '$SCRIPT_NAME' created and made executable."