from urllib.parse import urljoin
import os
import json
from tqdm import tqdm
from src.crawler.spiders.ElementExtractor import ElementExtractor
from src.crawler.utils.files import save_json
from lxml import html
import requests


class TextExtractor(ElementExtractor):
    def __init__(
        self,
        **kwargs,
    ):
        super().__init__(**kwargs)
        self.kwargs = kwargs
        self.targets = kwargs.get("targets")
        self.extractor_type = self.__class__.__name__

    def extract(self, element, **kwargs):
        """Extract text matching the XPath from the webpage."""
        text = element.text_content()
        return {"text": text}
