# Submission Reminder App



This is a Bash-based tool to help identify students who have not submitted their assignments.



---



## What It Does



- Creates a structured environment for a simple reminder app.

- Allows the user to change the assignment name via a second script (copilot_shell_script.sh).

- Checks a list of students and shows who hasn’t submitted.



---



## Files in This Repository



| File                     | Description                                              |

|--------------------------|----------------------------------------------------------|

| `create_environment.sh`  | Creates the full project structure and populates all necessary files. |

| `copilot_shell_script.sh`| Lets user change the assignment name and reruns the reminder. |

| `README.md`              | You're reading it. Instructions to run the app.          |



---



##  How to Use it



### 1. Setup the App Environment



1. Clone or download this repo and `cd` into it.  

2. Make the setup script executable:

   ```bash

   chmod +x create_environment.sh

3. Run the script with './create_environment.sh'

4. Run  'copilot_shell_script.sh' to change the assignment to check for.



#### Note: There are other files that need to be used, they are in the feature/setup file