from fastapi import APIRouter
from typing import Union
import tempfile
from pathlib import Path

import yt_dlp
from fastapi import APIRouter, HTTPException, BackgroundTasks
from fastapi.responses import FileResponse

from src.api.utils import remove_file, sanitize_filename


TEMP_DIR = Path(tempfile.gettempdir()) / "youtube_downloads"
TEMP_DIR.mkdir(exist_ok=True)

youtube_router = APIRouter(tags=["youtube"])


@youtube_router.get("/youtube/")
def get_youtube_data(url: str, background_tasks: BackgroundTasks):

    try:
        output_file = TEMP_DIR / "video.mp4"
        ydl_opts = {
            "format": "best",
            "outtmpl": str(output_file),
            "quiet": True,
            "no_warnings": True,
            "nocheckcertificate": True,
        }

        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            info = ydl.extract_info(url, download=False)
            video_title = info.get("title", "youtube_video")
            ydl.download([url])

        safe_title = sanitize_filename(video_title)
        filename = f"{safe_title}.mp4"

        if output_file.exists():
            background_tasks.add_task(remove_file, str(output_file))
            return FileResponse(
                path=str(output_file),
                filename=filename,
                media_type="video/mp4",
            )
        else:
            raise HTTPException(status_code=500, detail="Failed to download video")

    except Exception as e:
        raise HTTPException(
            status_code=500, detail=f"Error downloading video: {str(e)}"
        )
