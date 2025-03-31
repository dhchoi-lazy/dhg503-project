from urllib.parse import urljoin
import os
import requests
from src.crawler.utils.files import save_json
from src.crawler.utils.url import construct_url
from tqdm import tqdm
from src.crawler.spiders.ElementExtractor import ElementExtractor
from lxml import html


class ImageExtractor(ElementExtractor):
    def __init__(
        self,
        **kwargs,
    ):
        super().__init__(**kwargs)
        self.kwargs = kwargs
        self.targets = kwargs.get("targets")
        self.save_images = kwargs.get("save_images")

    def extract(self, element, **kwargs):

        if element.tag != "img":

            return {}

        try:
            src = element.get("src")
            alt = element.get("alt", "")
            if kwargs.get("save_images") is True:
                self.save_image(src)

            return {"url": src, "alt": alt}
        except Exception as e:

            return {}

    def save_image(self, url):
        """Download and save the image."""
        try:
            output_dir = self.kwargs.get("output_dir")
            if not output_dir:
                return False

            os.makedirs(output_dir, exist_ok=True)

            filename = os.path.basename(url.split("?")[0])
            output_path = os.path.join(output_dir, filename)

            # Check if file already exists
            if os.path.exists(output_path):
                return True

            # Add retry logic
            max_retries = 3
            retry_delay = 2  # seconds

            for attempt in range(max_retries):
                try:
                    # Set a proper user agent to mimic a browser
                    headers = {
                        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
                        "Referer": self.kwargs.get("ref_url", url),
                    }

                    # Download the image
                    response = self.session.get(url, stream=True, headers=headers)
                    response.raise_for_status()

                    # Save the image
                    with open(output_path, "wb") as f:
                        for chunk in response.iter_content(chunk_size=8192):
                            f.write(chunk)

                    return True

                except requests.exceptions.HTTPError as e:
                    if e.response.status_code == 403 and attempt < max_retries - 1:
                        wait_time = retry_delay * (2**attempt)  # Exponential backoff
                        import time

                        time.sleep(wait_time)
                    else:
                        raise  # Re-raise if it's the last attempt or a different error

            return False
        except Exception as e:
            return False
