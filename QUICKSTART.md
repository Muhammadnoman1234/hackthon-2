# 🚀 TaskFlow AI - Quick Start Guide

## ✅ All Errors Fixed!

This guide will help you run the TaskFlow AI application without any errors.

## 📋 Prerequisites

Before running the application, ensure you have:

1. **Node.js** (v18 or later) - [Download here](https://nodejs.org/)
2. **Python** (v3.8 or later) - [Download here](https://www.python.org/)

## 🎯 Quick Start (Recommended)

### Option 1: Run Full Stack (Frontend + Backend)

Simply double-click or run:
```bash
start.bat
```

This will:
- ✅ Check for Node.js and Python
- ✅ Install all dependencies automatically
- ✅ Start the backend server on port 8000
- ✅ Start the frontend server on port 3000
- ✅ Open both in separate windows

### Option 2: Run Frontend Only

If you only want to test the UI:
```bash
start_frontend_only.bat
```

This will start just the Next.js frontend on port 3000.

## 🌐 Access the Application

Once started, you can access:

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8000
- **API Documentation**: http://localhost:8000/docs

## 🔧 Manual Setup (If needed)

### Frontend Setup

```bash
cd frontend
npm install
npm run dev
```

### Backend Setup

```bash
cd backend

# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate.bat
# On Mac/Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Run the server
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

## 🐛 Fixes Applied

### 1. Backend Import Errors ✅
- Fixed relative imports in `backend/main.py`
- Added `__init__.py` to make backend a proper Python package
- Added missing `PyJWT` dependency to `requirements.txt`

### 2. Environment Variables ✅
- Created `.env.local` for frontend
- Created `.env` for backend
- Both files have sensible defaults that work out of the box

### 3. Startup Scripts ✅
- Created `start.bat` for full stack startup
- Created `start_frontend_only.bat` for frontend-only startup
- Both scripts check for dependencies and install them automatically

## 📁 Project Structure

```
hackthon 2/
├── frontend/               # Next.js frontend
│   ├── src/
│   │   ├── app/           # Next.js app directory
│   │   ├── components/    # React components
│   │   └── lib/           # Utility functions
│   ├── .env.local         # Frontend environment variables
│   └── package.json
│
├── backend/               # FastAPI backend
│   ├── main.py           # Main API server
│   ├── models.py         # Database models
│   ├── auth.py           # Authentication logic
│   ├── ai_agent.py       # AI agent orchestrator
│   ├── .env              # Backend environment variables
│   └── requirements.txt
│
├── start.bat             # Full stack startup script
└── start_frontend_only.bat  # Frontend-only startup script
```

## 🎨 Features

### Frontend
- ✨ Premium glassmorphism UI design
- 🎯 Task management dashboard
- 🤖 AI agent chat interface
- 🔐 Authentication pages (signin/signup)
- 📱 Fully responsive design
- 🌙 Dark mode with animated gradients

### Backend
- 🚀 FastAPI REST API
- 💾 SQLite database (upgradeable to PostgreSQL)
- 🔒 JWT authentication with Better Auth
- 🤖 OpenAI integration for AI agent
- 📊 Full CRUD operations for tasks

## 🔑 Environment Variables

### Frontend (.env.local)
```env
OPENAI_API_KEY=sk-placeholder          # Optional: Add your OpenAI key
NEXT_PUBLIC_API_URL=http://localhost:8000
BETTER_AUTH_SECRET=shared-secret-key-123
```

### Backend (.env)
```env
DATABASE_URL=sqlite:///./todo.db       # SQLite by default
OPENAI_API_KEY=sk-placeholder          # Optional: Add your OpenAI key
BETTER_AUTH_SECRET=shared-secret-key-123
HOST=0.0.0.0
PORT=8000
```

## 🚨 Troubleshooting

### "Node.js not found"
- Install Node.js from https://nodejs.org/
- Make sure to restart your terminal after installation

### "Python not found"
- Install Python from https://www.python.org/
- During installation, check "Add Python to PATH"
- Restart your terminal after installation

### "Port already in use"
- Frontend (3000): Stop any other Next.js apps
- Backend (8000): Stop any other FastAPI/uvicorn processes
- Or change the ports in the startup scripts

### Frontend won't start
```bash
cd frontend
rm -rf node_modules .next
npm install
npm run dev
```

### Backend won't start
```bash
cd backend
rm -rf venv
python -m venv venv
venv\Scripts\activate.bat
pip install -r requirements.txt
uvicorn main:app --reload
```

## 📝 Development Notes

### Adding OpenAI Integration
1. Get an API key from https://platform.openai.com/
2. Update `OPENAI_API_KEY` in both `.env.local` and `.env`
3. Restart both servers

### Database
- By default, uses SQLite (`todo.db` file)
- To use PostgreSQL, update `DATABASE_URL` in `backend/.env`
- Example: `DATABASE_URL=postgresql://user:pass@localhost/dbname`

## 🎯 Next Steps

1. **Run the app**: Use `start.bat`
2. **Create an account**: Go to http://localhost:3000/auth/signup
3. **Start managing tasks**: Use the dashboard
4. **Chat with AI**: Use the AI agent interface

## 💡 Tips

- The app works **without** an OpenAI API key (uses mock responses)
- All data is stored locally in SQLite
- No internet connection required for basic functionality
- Authentication is handled via Better Auth

## 🆘 Need Help?

If you encounter any issues:
1. Check that both Node.js and Python are installed
2. Make sure ports 3000 and 8000 are available
3. Try the manual setup steps above
4. Check the terminal output for specific error messages

---

**Enjoy using TaskFlow AI! 🎉**
