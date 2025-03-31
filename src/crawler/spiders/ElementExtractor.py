from urllib.parse import urljoin
import os
import json
from tqdm import tqdm
from src.crawler.spiders.BaseCrawler import BaseCrawler
from src.crawler.utils.files import save_json
import requests
from lxml import html
from src.crawler.utils.url import construct_url


class ElementExtractor(BaseCrawler):
    def __init__(
        self,
        **kwargs,
    ):
        super().__init__(**kwargs)
        self.kwargs = kwargs
        self.targets = kwargs.get("targets")
        self.extractor_type = self.__class__.__name__

    def crawl(self):
        """Process each target and extract text content."""
        results = []

        if self.extractor_type == "UrlExtractor":
            return self.crawl_recursively()

        for target in tqdm(
            self.targets, desc=f"Processing {self.extractor_type} targets"
        ):

            input_url = target.get("url")

            xpath = target.get("xpath")

            if not input_url or not xpath:

                continue

            try:
                html_content = self.fetch_page(input_url)
                page = html.fromstring(html_content)
                elements = page.xpath(xpath)

                for element in elements:
                    item = self.extract(element, **self.kwargs)
                    item["source_url"] = input_url
                    results.append(item)

            except Exception as e:
                raise

        save_json(
            results,
            self.kwargs.get("output_dir"),
            self.kwargs.get("source_name"),
            filename=self.kwargs.get("output_filename"),
        )

        return results

    def extract(self, element):
        """Child classes should implement this method."""
        raise NotImplementedError(
            f"{self.extractor_type} must implement the extract method."
        )

    def crawl_recursively(self):
        """Child classes should implement this method."""
        raise NotImplementedError(
            f"{self.extractor_type} must implement the extract method."
        )
