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
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
def read_root():
    return {"message": "Hello, World!"}
