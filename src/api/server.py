from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from src.api.router.basic import basic_router
from src.api.router.yt import youtube_router

app = FastAPI()
app.include_router(basic_router)
app.include_router(youtube_router)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins in development
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)


@app.get("/")
def read_root():
    return {"message": "Hello, World!"}
