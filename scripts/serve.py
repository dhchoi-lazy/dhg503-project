import uvicorn
import sys
import os


sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from src.api.server import app

if __name__ == "__main__":
    host = "0.0.0.0"
    port = 8000

    uvicorn.run("src.api.root:app", host=host, port=port)
