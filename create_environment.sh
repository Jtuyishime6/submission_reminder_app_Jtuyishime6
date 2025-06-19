#!/bin/bash

# Prompt the user for their name
echo "Please enter your name:"
read -r user_name

# Create the main directory
main_dir="submission_reminder_${user_name}"
if [ -d "$main_dir" ]; then
    echo "Directory $main_dir already exists. Please remove it or choose a different name."
    exit 1
fi
mkdir -p "$main_dir"
echo "Created directory: $main_dir"

# Create subdirectories
mkdir -p "${main_dir}/app"
mkdir -p "${main_dir}/assets"
mkdir -p "${main_dir}/config"
mkdir -p "${main_dir}/modules"
echo "Created subdirectories: app, assets, config, modules"

# --- Populate Files ---

# Create config/config.env
cat > "${main_dir}/config/config.env" << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Create modules/functions.sh
cat > "${main_dir}/modules/functions.sh" << 'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

# Create app/reminder.sh
cat > "${main_dir}/app/reminder.sh" << 'EOF'
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

# Create assets/submissions.txt with 5 additional records
cat > "${main_dir}/assets/submissions.txt" << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Imena, Shell Navigation, submitted
John Doe, Shell Navigation, not submitted
Jane Smith, Git, not submitted
Peter Jones, Shell Basics, submitted
Emily White, Advanced Scripting, not submitted
Michael Brown, Shell Navigation, not submitted
EOF

# Create startup.sh
cat > "${main_dir}/startup.sh" << 'EOF'
#!/bin/bash

# This script starts the reminder application
echo "Starting the submission reminder application..."
bash ./app/reminder.sh
EOF

# --- Set Permissions ---

# Make all .sh files executable
chmod +x "${main_dir}/modules/functions.sh"
chmod +x "${main_dir}/app/reminder.sh"
chmod +x "${main_dir}/startup.sh"
echo "Set executable permissions for all .sh files."

echo "Environment setup complete. You can now run the application from the '$main_dir' directory using './startup.sh'"
