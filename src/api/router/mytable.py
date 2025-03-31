from fastapi import APIRouter, Query, HTTPException
from sqlalchemy import text
from src.database.db import connect_db


mytable_router = APIRouter(tags=["mytable"])


@mytable_router.get("/all_mytable")
def read_all_articles(page: int = Query(1, description="Page number")):
    limit = 100
    offset = (page - 1) * limit

    engine = connect_db()
    with engine.connect() as conn:
        query = text(
            f"SELECT * FROM mytable ORDER BY id LIMIT {limit} OFFSET {offset} "
        )

        result = conn.execute(query)
        # Convert SQLAlchemy Row objects to dictionaries
        articles = [dict(row._mapping) for row in result]

        count_query = text("SELECT COUNT(*) FROM mytable")
        count_result = conn.execute(count_query)
        total_count = count_result.scalar()

        return {
            "articles": articles,
            "page": page,
            "limit": limit,
            "total": total_count,
            "total_pages": (total_count + limit - 1) // limit,
        }


@mytable_router.get("/article/{article_id}")
def read_article_by_id(article_id: int):
    engine = connect_db()
    with engine.connect() as conn:
        try:
            query = text(f"SELECT * FROM mytable WHERE id = {article_id}")
            result = conn.execute(query)
            articles = [dict(row._mapping) for row in result]
            return articles[0]
        except Exception as e:
            raise HTTPException(status_code=404, detail=f"Article not found")


@mytable_router.get("/search_mytable")
def search_articles(keyword: str = Query(..., description="Search keyword")):
    engine = connect_db()
    with engine.connect() as conn:
        # Use parameterized query to prevent SQL injection
        query = text("SELECT * FROM mytable WHERE content LIKE :search_pattern")
        result = conn.execute(query, {"search_pattern": f"%{keyword}%"})
        articles = [dict(row._mapping) for row in result]
        return {"keyword": keyword, "total": len(articles), "articles": articles}
