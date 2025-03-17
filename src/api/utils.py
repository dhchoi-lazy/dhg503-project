import os
import re


def remove_file(path: str):
    try:
        os.unlink(path)
    except Exception as e:
        print(f"Error removing file: {e}")


def sanitize_filename(title):
    sanitized = re.sub(r'[\\/*?:"<>|]', "_", title)
    return sanitized[:100]
