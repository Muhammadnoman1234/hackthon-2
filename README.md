# Todo Console Application

A command-line Todo application built with Python that provides full CRUD functionality for task management.

## Features

- ✅ Create, Read, Update, Delete (CRUD) operations for tasks
- 📝 Task validation (title 1-200 chars, description 0-1000 chars)
- ✅ Mark tasks as complete/incomplete
- 🔍 Search tasks by title or description
- 📊 View task statistics and completion rates
- 💾 Persistent data storage using JSON
- 🖥️ Interactive console interface
- ⌨️ Keyboard-friendly navigation

## Project Structure

```
todo_app/
├── models/
│   ├── __init__.py
│   └── task.py          # Task data model
├── services/
│   ├── __init__.py
│   └── task_service.py  # Business logic and data persistence
├── ui/
│   ├── __init__.py
│   └── console_ui.py    # Console interface
├── data/
│   └── tasks.json       # Persistent data storage (auto-created)
├── main.py              # Application entry point
└── run.bat              # Windows batch script to run the app
```

## Prerequisites

- Python 3.7 or later
- Windows, macOS, or Linux operating system

## Installation

1. Ensure Python 3.7+ is installed on your system
2. Clone or download this repository
3. No additional packages are required (uses only Python standard library)

## Running the Application

### Method 1: Using the batch file (Windows)
```bash
run.bat
```

### Method 2: Direct Python execution
```bash
python main.py
```

### Method 3: Alternative Python commands
```bash
py main.py
# or
python3 main.py
```

## Usage Guide

### Main Menu Options

1. **View all tasks** - Display all tasks with completion status
2. **View active tasks** - Show only incomplete tasks
3. **View completed tasks** - Show only completed tasks
4. **Add new task** - Create a new task with title and optional description
5. **Update task** - Modify existing task title or description
6. **Toggle task completion** - Mark task as complete/incomplete
7. **Delete task** - Remove a task (with confirmation)
8. **Search tasks** - Find tasks by title or description
9. **Show statistics** - Display task counts and completion rates
0. **Exit** - Quit the application

### Task Management

#### Creating Tasks
- Title is required (1-200 characters)
- Description is optional (0-1000 characters)
- Tasks are automatically assigned sequential IDs

#### Updating Tasks
- You can modify title and/or description
- Press Enter to keep current values
- Type "none" to remove description

#### Task Status
- Active tasks show `[ ]` 
- Completed tasks show `[✓]`
- Use option 6 to toggle completion status

### Navigation

- Enter menu numbers (0-9) to select options
- Press Enter to continue after operations
- Use Ctrl+C to exit the application
- Type 'h' or 'help' for assistance

## Data Persistence

- All tasks are automatically saved to `data/tasks.json`
- Data persists between application sessions
- JSON format ensures easy backup and transfer
- Directory is created automatically if it doesn't exist

## Task Model Specifications

```python
@dataclass
class Task:
    id: int                    # Unique sequential identifier
    title: str                 # Required, 1-200 characters
    description: Optional[str] # Optional, max 1000 characters
    completed: bool            # Completion status (default: False)
    created_at: datetime       # Auto-generated timestamp
    updated_at: datetime       # Auto-updated timestamp
```

## Error Handling

The application includes comprehensive error handling for:
- Invalid input validation
- File I/O operations
- Data serialization/deserialization
- User interruption (Ctrl+C)
- Unexpected exceptions

## Development

### Key Components

1. **Task Model** (`models/task.py`)
   - Data validation and business rules
   - Serialization methods
   - String representation

2. **Task Service** (`services/task_service.py`)
   - CRUD operations
   - Data persistence
   - Task filtering and search
   - Statistics calculation

3. **Console UI** (`ui/console_ui.py`)
   - Interactive menus
   - User input handling
   - Formatted output
   - Error messaging

### Extending the Application

To add new features:
1. Add methods to `TaskService` for new business logic
2. Create corresponding UI methods in `ConsoleUI`
3. Add menu options in the `print_menu()` method
4. Register handlers in `handle_choice()`

## Troubleshooting

### Common Issues

**Python not found:**
- Install Python from [python.org](https://www.python.org/downloads/)
- Make sure to check "Add Python to PATH" during installation

**Permission denied:**
- Ensure you have write permissions to the application directory
- The `data/` directory needs write access for JSON storage

**Data file corruption:**
- Delete `data/tasks.json` to start fresh
- The application will create a new empty file

**Encoding issues:**
- The application uses UTF-8 encoding for data files
- Should work with international characters

## License

This project is free to use and modify.

## Author

Built as a demonstration of Python console application development with clean architecture principles.