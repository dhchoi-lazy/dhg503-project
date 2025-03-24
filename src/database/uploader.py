from sqlalchemy import text
from src.database.db import connect_db


class ShiluUploader:

    def __init__(self, data):
        self.data = data
        self.engine = connect_db()
        self.create_table_sql = """
DROP TABLE IF EXISTS mqshilu;
CREATE TABLE mqshilu (
    id INTEGER PRIMARY KEY,
    url TEXT,
    title TEXT,
    year INTEGER,
    date TEXT,
    content TEXT,
    king TEXT
    
);
"""
        # Execute SQL statements within a transaction

    def upload(self):
        with self.engine.connect() as conn:
            conn.execute(text("BEGIN"))
            conn.execute(text(self.create_table_sql))

            # Insert data row by row from the DataFrame
            for entry in self.data:
                insert_sql = text(
                    """
                    INSERT INTO mqshilu (id, url, title, year, date, content, king)
                    VALUES (:id, :url, :title, :year, :date, :content, :king)
                    """
                )
                conn.execute(
                    insert_sql,
                    {
                        "id": entry["id"],
                        "url": entry["url"],
                        "title": entry["title"],
                        "year": entry["year"],
                        "date": entry["date"],
                        "content": entry["content"],
                        "king": entry["king"],
                    },
                )

            conn.execute(text("COMMIT"))
            print("Data successfully saved to the PostgreSQL database.")
