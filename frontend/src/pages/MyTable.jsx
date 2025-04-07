import React, { useState, useEffect, useCallback } from "react";
import { useLocation } from "react-router-dom";
import Sidebar from "../components/Sidebar";
import MainContent from "../components/MainContent";

const sampleArticle = {
  id: 100,
  url: "https://sillok.history.go.kr/mc/id/msilok_003_0060_0010_0010_0100_0010",
  title: "仁宗昭皇帝實錄 卷三上 永樂二十二年 十月 十日",
  year: 1424,
  date: "永樂二十二年 十月 十日",
  content:
    "辛亥勑甘肅縂兵官都督費近聞賢義王太平為瓦賴瓦賴:抱本中本作瓦剌，是也。順寧王脫歡所侵害太平人馬潰散有迯至甘肅邊境潛住者爾等即整搠士馬哨瞭如果則遣人詔諭如果則遣人詔諭:三本作如果是實則遣人招諭。同來仍嚴束束:舊校改作約束。差去人善加撫恤毌盜其馬疋牛羊等物庶不失遠人來歸之心命羽林前衛指揮僉僉事指揮僉僉事:舊校刪一僉字。汪致淵子㒮祖龍職汪致淵子㒮祖龍職:舊校改㒮作豗，龍作襲。古麻剌等正國剌必等吉麻剌等正國剌必等:舊校改正國作國王。三本必作苾。遣頭目叭諦吉三等奉金葉表箋來朝貢方物賜之鈔幣賜之鈔幣:廣本幣下有有差二字。",
  king: "仁宗昭皇帝",
};

const TOTAL_PAGES = 100;

function MyTable() {
  const [articles, setArticles] = useState([]);
  const [selectedArticle, setSelectedArticle] = useState(null);
  const [currentArticleId, setCurrentArticleId] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [isLoadingList, setIsLoadingList] = useState(false);
  const [isLoadingArticle, setIsLoadingArticle] = useState(false);
  const [errorList, setErrorList] = useState(null);
  const [errorArticle, setErrorArticle] = useState(null);
  const [searchQuery, setSearchQuery] = useState("");
  const [isSearchMode, setIsSearchMode] = useState(false);
  const [isSearching, setIsSearching] = useState(false);

  const location = useLocation();

  const fetchArticleList = useCallback(
    async (page) => {
      setIsLoadingList(true);
      setErrorList(null);
      console.log(`Fetching articles for page: ${page}`);
      try {
        // IMPORTANT: The API endpoint is /api/all_mytable?page=${page}.
        // YOU CAN CHANGE ANY API ENDPOINT YOU WANT.
        // In this case, you must have `id` column in the data.
        const response = await fetch(`/api/all_mytable?page=${page}`);
        if (!response.ok) {
          throw new Error(`Server returned ${response.status}`);
        }
        const data = await response.json();
        setArticles(data.articles || []);

        if (page === 1 && !currentArticleId && data.articles?.length > 0) {
          setCurrentArticleId(data.articles[0].id);
        } else if (page === 1 && !currentArticleId) {
          setCurrentArticleId(sampleArticle.id);
        }
      } catch (error) {
        console.error("Error fetching article list:", error);
        setErrorList(
          `Failed to load articles: ${error.message}. Please check if the API server is running.`
        );
        setArticles([]);
        if (page === 1 && !currentArticleId) {
          setCurrentArticleId(sampleArticle.id);
        }
      } finally {
        setIsLoadingList(false);
      }
    },
    [currentArticleId]
  );

  useEffect(() => {
    const params = new URLSearchParams(location.search);
    const articleIdFromUrl = params.get("articleId");

    if (articleIdFromUrl) {
      console.log(`Found articleId in URL: ${articleIdFromUrl}`);
      setCurrentArticleId(Number(articleIdFromUrl));
    }
  }, [location]);

  const fetchArticle = useCallback(async (id) => {
    if (!id) return;

    setIsLoadingArticle(true);
    setErrorArticle(null);
    setSelectedArticle(null);
    console.log(`Fetching article with ID: ${id}`);
    try {
      const response = await fetch(`/api/article_mytable/${id}`);
      if (!response.ok) {
        if (response.status === 404 || response.status >= 500) {
          console.warn(
            `Article ${id} not found or server error (${response.status}), loading sample data.`
          );
          setSelectedArticle(sampleArticle);
          setCurrentArticleId(sampleArticle.id);
          setErrorArticle(`Article ${id} not found. Displaying sample.`);
        } else {
          throw new Error(`Server returned ${response.status}`);
        }
      } else {
        const data = await response.json();
        setSelectedArticle(data);
      }
    } catch (error) {
      console.error("Error fetching article:", error);
      setErrorArticle(`Failed to load article ${id}: ${error.message}`);
      setSelectedArticle(sampleArticle);
      setCurrentArticleId(sampleArticle.id);
    } finally {
      setIsLoadingArticle(false);
    }
  }, []);

  // Search articles
  const searchArticles = useCallback(async () => {
    if (!searchQuery.trim()) {
      setIsSearchMode(false);
      fetchArticleList(currentPage);
      return;
    }

    setIsSearching(true);
    setIsSearchMode(true);
    setErrorList(null);

    try {
      const response = await fetch(
        `/api/search_mytable?keyword=${encodeURIComponent(searchQuery.trim())}`
      );
      if (!response.ok) {
        throw new Error(`Server returned ${response.status}`);
      }

      const data = await response.json();
      setArticles(data.articles || []);

      if (data.articles?.length > 0) {
        setCurrentArticleId(data.articles[0].id);
      }
    } catch (error) {
      console.error("Error searching articles:", error);
      setErrorList(
        `Failed to search: ${error.message}. Please check if the API server is running.`
      );
      setArticles([]);
    } finally {
      setIsSearching(false);
    }
  }, [searchQuery, currentPage, fetchArticleList]);

  useEffect(() => {
    if (!isSearchMode) {
      fetchArticleList(currentPage);
    }
  }, [currentPage, fetchArticleList, isSearchMode]);

  useEffect(() => {
    fetchArticle(currentArticleId);
  }, [currentArticleId, fetchArticle]);

  const handleSelectArticle = (id) => {
    setCurrentArticleId(id);
  };

  const handlePrevPage = () => {
    if (isSearchMode) {
      clearSearch();
    } else if (currentPage > 1) {
      setCurrentPage((prevPage) => prevPage - 1);
    }
  };

  const handleNextPage = () => {
    if (currentPage < TOTAL_PAGES) {
      setCurrentPage((prevPage) => prevPage + 1);
    }
  };

  const handleSearchChange = (e) => {
    setSearchQuery(e.target.value);
  };

  const handleSearchSubmit = (e) => {
    e.preventDefault();
    searchArticles();
  };

  const clearSearch = () => {
    setSearchQuery("");
    setIsSearchMode(false);
    fetchArticleList(currentPage);
  };

  return (
    <>
      <div className="pt-[20px] mx-auto w-full">
        <Sidebar
          articles={articles}
          currentArticleId={currentArticleId}
          currentPage={currentPage}
          totalPages={isSearchMode ? 1 : TOTAL_PAGES}
          onSelectArticle={handleSelectArticle}
          onPrevPage={handlePrevPage}
          onNextPage={handleNextPage}
          isLoading={isLoadingList || isSearching}
          error={errorList}
          searchQuery={searchQuery}
          onSearchChange={handleSearchChange}
          onSearchSubmit={handleSearchSubmit}
          onClearSearch={clearSearch}
          isSearchMode={isSearchMode}
          isSearching={isSearching}
        />
        <MainContent
          article={selectedArticle}
          isLoading={isLoadingArticle}
          error={errorArticle}
        />
      </div>
    </>
  );
}

export default MyTable;
