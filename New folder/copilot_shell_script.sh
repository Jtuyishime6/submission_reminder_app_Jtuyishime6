#!/bin/bash

# Define the directory path
main_dir="submission_reminder_tuyishime"

echo "Please enter the new assignment name:"
read -r new_assignment

# Define the config file path
config_file="${main_dir}/config/config.env"

# Check if config file exists
if [ ! -f "$config_file" ]; then
    echo "Error: Config file not found at '$config_file'."
    exit 1
fi

# Use sed to replace the assignment name in the config file
# The `"` around `$new_assignment` are important to keep the value quoted in the file
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$config_file"

echo "Updated assignment to '$new_assignment' in '$config_file'."
echo "---"

# Run the startup script to see the new reminders
echo "Running the application with the new assignment..."
cd "$main_dir" && ./startup.sh
