from fastapi import APIRouter, Query, HTTPException
from sqlalchemy import text
from src.database.db import connect_db
import re

mqshilu_router = APIRouter(tags=["mqshilu"])


@mqshilu_router.get("/all_articles")
def read_all_articles(page: int = Query(1, description="Page number")):
    limit = 100
    offset = (page - 1) * limit

    engine = connect_db()
    with engine.connect() as conn:
        query = text(
            f"SELECT * FROM mqshilu ORDER BY id LIMIT {limit} OFFSET {offset} "
        )

        result = conn.execute(query)
        # Convert SQLAlchemy Row objects to dictionaries
        articles = [dict(row._mapping) for row in result]

        count_query = text("SELECT COUNT(*) FROM mqshilu")
        count_result = conn.execute(count_query)
        total_count = count_result.scalar()

        return {
            "articles": articles,
            "page": page,
            "limit": limit,
            "total": total_count,
            "total_pages": (total_count + limit - 1) // limit,
        }


@mqshilu_router.get("/article/{article_id}")
def read_article_by_id(article_id: int):
    engine = connect_db()
    with engine.connect() as conn:
        try:
            query = text(f"SELECT * FROM mqshilu WHERE id = {article_id}")
            result = conn.execute(query)
            articles = [dict(row._mapping) for row in result]
            return articles[0]
        except Exception as e:
            raise HTTPException(status_code=404, detail=f"Article not found")


@mqshilu_router.get("/statistics")
def read_statistics():
    engine = connect_db()
    with engine.connect() as conn:

        query = text("SELECT COUNT(*) as total FROM mqshilu")
        result = conn.execute(query)
        total = result.scalar()

        query = text(
            "SELECT king, COUNT(*) as count FROM mqshilu GROUP BY king ORDER BY count DESC"
        )
        result = conn.execute(query)
        # Convert SQLAlchemy Row objects to dictionaries
        cnt_by_king = [dict(row._mapping) for row in result]
        query = text(
            "SELECT year, COUNT(*) as count FROM mqshilu GROUP BY year ORDER BY count DESC"
        )
        result = conn.execute(query)
        cnt_by_year = [dict(row._mapping) for row in result]

        return {
            "total": total,
            "cnt_by_king": cnt_by_king,
            "cnt_by_year": cnt_by_year,
        }


@mqshilu_router.get("/search")
def search_articles(keyword: str = Query(..., description="Search keyword")):
    engine = connect_db()
    with engine.connect() as conn:
        # Use parameterized query to prevent SQL injection
        query = text("SELECT * FROM mqshilu WHERE content LIKE :search_pattern")
        result = conn.execute(query, {"search_pattern": f"%{keyword}%"})
        articles = [dict(row._mapping) for row in result]
        return {"keyword": keyword, "total": len(articles), "articles": articles}


@mqshilu_router.get("/network_data")
def get_network_data(
    limit: int = Query(200, description="Number of articles to analyze")
):
    engine = connect_db()
    with engine.connect() as conn:
        # Get articles with content, king, and year to analyze
        query = text(
            f"SELECT id, title, year, content FROM mqshilu WHERE content IS NOT NULL AND year IS NOT NULL ORDER BY year LIMIT {limit}"
        )
        result = conn.execute(query)
        articles = [dict(row._mapping) for row in result]

        # Extract person entities (common family names followed by given names)
        person_pattern = re.compile(
            r"[趙錢孫李周吳鄭王馮陳褚衛蔣沈韓楊朱秦尤許何呂施張孔曹][^\s，。]{1,3}"
        )

        nodes = []
        links = []
        nodes_set = set()  # To track unique nodes
        article_people_map = {}  # To track which people appear in which articles

        # Extract all people from articles and build the article-people map
        for article in articles:
            if article["content"]:
                article_id = article["id"]
                year = article["year"]
                content = article["content"]

                # Extract persons
                persons = set(person_pattern.findall(content))
                article_people_map[article_id] = {
                    "persons": list(persons),
                    "year": year,
                }

                # Add person nodes if they don't exist
                for person in persons:
                    if len(person) > 1:
                        if person not in nodes_set:
                            nodes.append(
                                {
                                    "id": person,
                                    "name": person,
                                    "group": "person",
                                    "val": 2,
                                    "color": "#9966ff",
                                    "year": year,
                                }
                            )
                            nodes_set.add(person)

        # Connect people who appear in the same article
        for article_id, data in article_people_map.items():
            persons = data["persons"]
            year = data["year"]

            # Create edges between each pair of people in the same article
            for i in range(len(persons)):
                for j in range(i + 1, len(persons)):
                    if len(persons[i]) > 1 and len(persons[j]) > 1:
                        links.append(
                            {
                                "source": persons[i],
                                "target": persons[j],
                                "value": 1,
                                "year": year,
                            }
                        )

        # Count connections for each person and update node size
        connection_counts = {}
        for link in links:
            source = link["source"]
            target = link["target"]
            connection_counts[source] = connection_counts.get(source, 0) + 1
            connection_counts[target] = connection_counts.get(target, 0) + 1

        # Update node values based on connection counts
        for node in nodes:
            node_id = node["id"]
            if node_id in connection_counts:
                node["val"] = min(
                    10, 2 + connection_counts[node_id] * 0.5
                )  # Scale node size by connections

        # Get the min and max years
        years = [article["year"] for article in articles if article["year"]]
        min_year = min(years) if years else None
        max_year = max(years) if years else None

        return {
            "nodes": nodes,
            "links": links,
            "timeRange": {"min": min_year, "max": max_year},
        }
