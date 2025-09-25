# AI Q&A Chat Application

A Flutter-based frontend with a FastAPI backend using Google Gemini AI (or any LLM) for AI-powered Q&A ChatApp. The application allows full conversation context, maintaining chat history and generating AI replies.

---

## Table of Contents

1. [Project Structure](#project-structure)  
2. [Prerequisites](#prerequisites)  
3. [Backend Setup](#backend-setup)  
4. [Frontend Setup](#frontend-setup)  
5. [API Key Configuration](#api-key-configuration)  
6. [Running the Application](#running-the-application)  
7. [Usage](#usage)  

---

## Project Structure


AI_CHAT_APP/
├── backend/
│   ├── main.py
│   ├── requirements.txt
├── ai_chat_app (Flutter frontend)
|   |
|   |__lib
|   |   |
│   |   |--chat/
│   │   |   ├── chat_controller.dart
│   │   |   ├── chat_repository.dart
│   │   |   └── chat_screen.dart
│   ├   |--models/
│   │   |   └── message.dart
│   |   └──- main.dart
|   ├── pubspec.yaml
└── README.md

---

## Prerequisites

### Backend
- Python 3.10+  
- pip  
- [Google Generative AI Python SDK](https://pypi.org/project/google-generativeai/)  

### Frontend
- Flutter SDK (3.0+)  
- Dart  
- A working IDE (VSCode, Android Studio, etc.)  

---

## Backend Setup

1. Navigate to the backend folder:

```bash
cd ai_chat_app/backend
```

2. Create a virtual environment (optional but recommended):

```bash
python -m venv venv
source venv/bin/activate   # Linux/macOS
venv\Scripts\activate      # Windows
```

3. Install dependencies:

```bash
pip install -r requirements.txt
```

**Sample `requirements.txt`:**

```
fastapi
uvicorn
google-generativeai
python-dotenv
google-genai
```

4. Set your **Google Gemini API key** as an environment variable:

```bash
export GEMINI_API_KEY="YOUR_API_KEY"   # Linux/macOS
```

5. Run the backend:

```bash
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Backend will be available at: `http://localhost:8000`

---

## Frontend Setup

1. Navigate to the frontend folder:

```bash
cd ai_chat_app
```

2. Get Flutter dependencies:

```bash
flutter pub get
```

3. Run the frontend:

```bash
flutter run
```

> When prompted, select the target device (Chrome for web, Linux for desktop, or a connected mobile device).

---

## API Key Configuration

The **Google Gemini API key** is required to generate AI responses.  

- **Backend expects the key as an environment variable**:

```bash
export GEMINI_API_KEY="YOUR_API_KEY"  # Linux/macOS
set GEMINI_API_KEY="YOUR_API_KEY"     # Windows
```

- Alternatively, you can use a `.env` file with `python-dotenv` if you want:

```
GEMINI_API_KEY=YOUR_API_KEY
```

Then load it in `main.py`:

```python
from dotenv import load_dotenv
load_dotenv()
```

---

## Running the Application

1. **Start backend**:

```bash
cd backend
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

2. **Start frontend**:

```bash
cd ai_chat_app
flutter run
```

3. Open the frontend in the selected device/browser. Ask questions, and AI replies will appear in the chat interface.  

---

## Usage

- Type your message in the input field.  
- Press **Enter** or click the **send button**.  
- The AI assistant replies using the full conversation history to maintain context.  

> Both the user messages and AI replies are stored in `state` on the frontend and sent as `[{role, content}]` to the backend `/chat` endpoint.

# AI-Q-A-Chat-Application
