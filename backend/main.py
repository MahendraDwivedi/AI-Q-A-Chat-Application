import os
from fastapi import FastAPI, Request
from fastapi.responses import StreamingResponse
from fastapi.middleware.cors import CORSMiddleware
from dotenv import load_dotenv
from google import genai  # Google Gemini SDK

# Load environment variables
load_dotenv()
gemini_api_key = os.getenv("GEMINI_API_KEY")

# Initialize FastAPI app
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # or ["http://localhost:xxxx"] for stricter
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize Gemini client
client = genai.Client(api_key=gemini_api_key)

@app.get("/ping")
async def ping():
    """Simple test endpoint to check if server is running"""
    return {"status": "ok"}

@app.post("/chat")
async def chat(request: Request):
    data = await request.json()
    # internally call the same logic as /gemini-chat
    return await gemini_chat(request)

@app.post("/gemini-chat")
async def gemini_chat(request: Request):
    data = await request.json()
    messages = data.get("messages", [])

    async def event_generator():
        try:
            # Convert messages into a single string prompt
            prompt_text = "\n".join([f"{m['role']}: {m['content']}" for m in messages])

            # Generate response from Gemini
            response = client.models.generate_content(
                model="gemini-2.5-flash",  # You can change model here
                contents=prompt_text
            )
            ai_response = response.text  # ✅ extract string


            if ai_response.startswith("data:"):
             ai_response = ai_response[len("data:"):].strip()

            if ai_response.startswith("Reply:"):
             ai_response = ai_response[len("data:"):].strip()

            # Send response as SSE
            yield f"{ai_response}\n\n"
            yield "Reply: [DONE]\n\n"

        except Exception as e:
            yield f"Error: [ERROR] {str(e)}\n\n"

    return StreamingResponse(event_generator(), media_type="text/event-stream")
