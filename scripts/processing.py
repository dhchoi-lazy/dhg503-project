import glob
import json
import os
import pandas as pd
from sqlalchemy import create_engine
from src.processing.transform import ShiluTransformer
from src.database.uploader import ShiluUploader
from src.database.db import connect_db


def main():
    html_directory = "./data/raw/mqshilu/html/"
    filepaths = glob.glob(os.path.join(html_directory, "*.html"))
    html_docs = []

    for filepath in filepaths:
        try:
            with open(filepath, "r", encoding="utf-8") as f:
                doc = f.read()
                article_id = os.path.basename(filepath).split(".")[0]
                url = f"https://sillok.history.go.kr/mc/id/{article_id}"
                html_docs.append({"url": url, "html": doc})
        except Exception as e:
            print(f"Error loading file {filepath}: {e}")
    result = []
    for idx, html_doc in enumerate(html_docs):
        url = html_doc["url"]
        article_id = idx + 1
        transformer = ShiluTransformer(html_doc)
        data = transformer.transform()
        data["id"] = article_id
        data["url"] = url
        result.append(data)

    # Option 1: Save to csv

    df = pd.DataFrame(result)
    df.to_csv("data/processed/mqshilu.csv", index=False)

    # Option 2: Save to json
    with open("data/processed/mqshilu.json", "w") as f:
        json.dump(result, f)

    # Option 3: Save to excel
    df.to_excel("data/processed/mqshilu.xlsx", index=False)

    # Option 4: Save to Database
    uploader = ShiluUploader(result)
    uploader.upload()

    # # Option 5: Or save dataframe to Database
    # df.to_sql("mqshilu", con=connect_db(), if_exists="replace", index=False)


if __name__ == "__main__":
    main()
