import json
from pathlib import Path
import re
import os
from urllib.parse import urlparse, parse_qs
import asyncio
import hashlib


def save_json(data, directory, source_name, filename=None):

    if filename is None:
        filename = f"{source_name}.json"
    file_path = Path(directory) / filename

    file_path.parent.mkdir(parents=True, exist_ok=True)

    with open(file_path, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=4)


def load_json(file_path):

    with open(file_path, "r", encoding="utf-8") as f:
        return json.load(f)


def get_filepath(key, output_dir):

    return os.path.join(output_dir, f"{key}.html")


async def save_html_async(html, key, output_dir):

    try:
        file_path = get_filepath(key, output_dir)
        os.makedirs(os.path.dirname(file_path), exist_ok=True)
        await asyncio.to_thread(write_file, file_path, html)
        return file_path

    except Exception as e:
        raise e


def save_html(html, key, output_dir):
    file_path = get_filepath(key, output_dir)
    os.makedirs(os.path.dirname(file_path), exist_ok=True)
    write_file(file_path, html)
    return file_path


def write_file(file_path, content):
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(content)
