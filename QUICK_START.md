# Quick Start Guide

## Getting Started Quickly

### 1. Check Python Installation
Open Command Prompt and run:
```cmd
python --version
```
or
```cmd
py --version
```

If Python is not found, download it from [python.org](https://www.python.org/downloads/)

### 2. Run the Application
Double-click `run.bat` or run from Command Prompt:
```cmd
run.bat
```

### 3. First Time Usage
1. The application will create a `data/tasks.json` file automatically
2. You'll see the main menu with task statistics
3. Start by adding your first task (option 4)

## Basic Operations

### Adding Your First Task
1. Select option `4` from the menu
2. Enter a title (required, 1-200 characters)
3. Optionally add a description (0-1000 characters)
4. Press Enter to confirm

### Managing Tasks
- **View tasks**: Options 1, 2, or 3
- **Mark complete**: Option 6, enter task ID
- **Edit task**: Option 5, enter task ID and new details
- **Delete task**: Option 7, enter task ID and confirm
- **Search tasks**: Option 8, enter search term

### Exit the Application
Select option `0` or press `Ctrl+C`

## Example Workflow

```
1. Add "Buy groceries" with description "Milk, bread, eggs"
2. Add "Finish project report" 
3. View all tasks (option 1) to see your tasks
4. Mark "Buy groceries" as complete (option 6, enter ID 1)
5. View active tasks (option 2) to see remaining tasks
6. Exit when done (option 0)
```

## Data Location
Your tasks are saved in: `data/tasks.json`

This file is automatically created and updated. You can:
- Backup this file to save your tasks
- Share it with others
- Edit it manually (JSON format)
- Delete it to start fresh

## Need Help?
- Type `h` or `help` at any time
- Check the full README.md for detailed information
- All data is automatically saved - no manual saving needed