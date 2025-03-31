import sys
import os

from src.utils.config import load_config

# Import the classes directly from their respective modules

from src.crawler.spiders.UrlExtractor import UrlExtractor
from src.crawler.spiders.ImageExtractor import ImageExtractor
from src.crawler.spiders.TextExtractor import TextExtractor
from src.crawler.spiders.HTMLCrawler import HTMLCrawler


def main():
    # Setup logging

    # Map of crawler names to their class objects
    crawler_class_map = {
        "url_extractor": UrlExtractor,
        "image_extractor": ImageExtractor,
        "text_extractor": TextExtractor,
        "html_crawler": HTMLCrawler,
    }

    try:

        config = load_config()
        crawler_config = config.get("crawler", {})

        if not crawler_config:
            raise ValueError("No crawler configuration found in config.yaml")

        for crawler_class_name, crawler_class_config in crawler_config.items():
            crawler_class = crawler_class_map.get(crawler_class_name)
            if not crawler_class:
                raise ValueError(f"Unknown crawler class: {crawler_class_name}")

            sources = crawler_class_config.get("sources", {})
            if not sources:

                sys.exit(1)

            for source_name, source_config in sources.items():

                base_url = source_config.get("base_url")
                if not base_url:

                    sys.exit(1)

                targets = source_config.get("targets", [])
                source_config["source_name"] = source_name

                if not targets:
                    sys.exit(1)

                for target in targets:
                    if "url" not in target:
                        target["url"] = base_url

                source_config["targets"] = targets

                output_dir = source_config.get("output_dir", "data/raw")
                os.makedirs(output_dir, exist_ok=True)

                try:

                    crawler = crawler_class(
                        **source_config,
                    )
                    # Run the crawler and save the data
                    crawler.crawl()

                except Exception as e:

                    continue

    except Exception as e:
        sys.exit(1)


if __name__ == "__main__":
    main()
