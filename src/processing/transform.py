import pandas as pd
import glob
import os
from lxml import html
import re


class ShiluTransformer:
    def __init__(self, html_doc):

        self.html_doc = html_doc

        # XPath expressions for extracting information
        self.xpath_config = {
            "title": "/html/body/div[2]/div[2]/div[2]/div/div[1]/div/span/text()",
            "year": "/html/body/div[2]/div[2]/div[2]/div/div[1]/div/span/span/text()",
            "content": "/html/body/div[2]/div[2]/div[2]/div/div[3]/div/div//p",
            "date": "/html/body/div[2]/div[2]/div[2]/div/ul[1]/li[6]/a/text()",
            "king": "/html/body/div[2]/div[2]/div[2]/div/ul[1]/li[3]/a/@href",
        }

    def extract_information(self):

        try:
            url = self.html_doc["url"]
            doc = self.html_doc["html"]
            page = html.fromstring(doc)

            # Extract title
            title = page.xpath(self.xpath_config["title"])[0].strip()
            title = re.sub(r"\s+\d+번째기사", "", title)

            # Extract year (remove the '년' character)
            year_text = page.xpath(self.xpath_config["year"])[0].strip()
            year = int(year_text.replace("년", ""))

            # Extract content text
            content = " ".join(
                p.text_content().strip()
                for p in page.xpath(self.xpath_config["content"])
            )

            # Extract date
            date = page.xpath(self.xpath_config["date"])[0].strip()

            # Extract king information from the URL and clean it up
            king_raw = page.xpath(self.xpath_config["king"])[0].strip()
            king = king_raw.split(", ")[3].strip(";").strip("')").replace("實錄", "")

            info = {
                "title": title,
                "year": year,
                "date": date,
                "content": content,
                "king": king,
                "url": url,
            }

            return info
        except Exception as e:
            print(f"Error processing document from {url}: {e}")

    def transform(self):

        return self.extract_information()
