import asyncio
from tqdm import tqdm
from src.crawler.spiders.BaseCrawler import BaseCrawler
from src.crawler.utils.clean_html import clean_html
from src.crawler.utils.files import load_json, save_html
import os


class HTMLCrawler(BaseCrawler):

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.targets = kwargs.get("targets")
        self.concurrency_limit = kwargs.get("concurrency_limit", 20)
        self.semaphore = asyncio.Semaphore(self.concurrency_limit)
        self.input_file = kwargs.get("input_file")
        self.resumable = kwargs.get("resumable")

    def crawl(self):
        for target in self.targets:

            self.xpath = target.get("xpath")
            target_urls = load_json(self.input_file)

            if not target_urls:
                self.logger.error("No target_urls")
                return []

            max_depth = (
                max([t.get("depth", 0) for t in target_urls]) if not target_urls else 0
            )
            target_urls = [t for t in target_urls if t.get("depth", 0) == max_depth]
            if self.resumable:
                target_urls = [
                    url
                    for url in target_urls
                    if not os.path.exists(os.path.join(self.output_dir, url["key"]))
                ]

            if not target_urls:
                self.logger.warning("No target_urls found in the input file.")
                continue
            for target_url in tqdm(target_urls):
                key = target_url["key"]
                html_content = self.fetch_page(target_url["url"])
                page = clean_html(html_content, self.xpath)
                save_html(page, key, self.output_dir)
