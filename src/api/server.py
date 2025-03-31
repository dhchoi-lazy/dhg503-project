from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from src.api.router.basic import basic_router
from src.api.router.yt import youtube_router
from src.api.router.mqshilu import mqshilu_router

app = FastAPI()
app.include_router(basic_router)
app.include_router(youtube_router)
app.include_router(mqshilu_router)

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "*",  # Allow all origins
        "http://localhost",
        "http://localhost:80",
        "http://localhost:5173",
        "http://ec2-16-163-139-185.ap-east-1.compute.amazonaws.com",
        "http://ec2-16-163-139-185.ap-east-1.compute.amazonaws.com:80",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
def read_root():
    return {"message": "Hello, World!"}
