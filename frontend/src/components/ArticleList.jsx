import React from "react";

function ArticleList({ articles, currentArticleId, onSelectArticle }) {
  return (
    <ul className="list-none p-0">
      {articles.map((article) => (
        <li
          key={article.id}
          className={`py-3 px-3 mb-2 rounded cursor-pointer text-text transition-all duration-300 border-l-3 ${
            article.id === currentArticleId
              ? "bg-primary/12 border-l-primary text-primary font-medium"
              : "border-l-transparent hover:bg-primary/8 hover:border-l-border hover:translate-x-[3px]"
          }`}
          onClick={() => onSelectArticle(article.id)}
        >
          {article.title}
        </li>
      ))}
    </ul>
  );
}

export default ArticleList;
