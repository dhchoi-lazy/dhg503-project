import React, { useState, useEffect, useCallback } from "react";
import { useLocation } from "react-router-dom";

import Sidebar from "../components/Sidebar";
import MainContent from "../components/MainContent";

// Sample fallback data in case the API fails on initial load
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
const API_URL = import.meta.env.VITE_API_BASE_URL || "";

function MyTable() {
  const [articles, setArticles] = useState([]);
  const [selectedArticle, setSelectedArticle] = useState(null);
  const [currentArticleId, setCurrentArticleId] = useState(null); // Start with null
  const [currentPage, setCurrentPage] = useState(1);
  const [isLoadingList, setIsLoadingList] = useState(false);
  const [isLoadingArticle, setIsLoadingArticle] = useState(false);
  const [errorList, setErrorList] = useState(null);
  const [errorArticle, setErrorArticle] = useState(null);
  const [searchQuery, setSearchQuery] = useState("");
  const [isSearchMode, setIsSearchMode] = useState(false);
  const [isSearching, setIsSearching] = useState(false);

  // Get URL query parameters
  const location = useLocation();

  // Fetch Article List
  const fetchArticleList = useCallback(
    async (page) => {
      setIsLoadingList(true);
      setErrorList(null);
      console.log(`Fetching articles for page: ${page}`);
      try {
        const response = await fetch(`${API_URL}/api/all_mytable?page=${page}`);
        if (!response.ok) {
          throw new Error(`Server returned ${response.status}`);
        }
        const data = await response.json();
        setArticles(data.articles || []);
        // If it's the first page load and no article is selected yet,
        // select the first article from the list OR the default sample one
        if (page === 1 && !currentArticleId && data.articles?.length > 0) {
          setCurrentArticleId(data.articles[0].id);
        } else if (page === 1 && !currentArticleId) {
          setCurrentArticleId(sampleArticle.id); // Fallback if list is empty
        }
      } catch (error) {
        console.error("Error fetching article list:", error);
        setErrorList(
          `Failed to load articles: ${error.message}. Please check if the API server is running.`
        );
        setArticles([]); // Clear articles on error
        if (page === 1 && !currentArticleId) {
          setCurrentArticleId(sampleArticle.id); // Still try to load sample
        }
      } finally {
        setIsLoadingList(false);
      }
    },
    [currentArticleId]
  ); // Depend on currentArticleId to set initial selection correctly

  // Parse articleId from URL parameters when component mounts
  useEffect(() => {
    const params = new URLSearchParams(location.search);
    const articleIdFromUrl = params.get("articleId");

    if (articleIdFromUrl) {
      console.log(`Found articleId in URL: ${articleIdFromUrl}`);
      setCurrentArticleId(Number(articleIdFromUrl));
    }
  }, [location]);

  // Fetch Single Article
  const fetchArticle = useCallback(async (id) => {
    if (!id) return; // Don't fetch if ID is null

    setIsLoadingArticle(true);
    setErrorArticle(null);
    setSelectedArticle(null); // Clear previous article while loading
    console.log(`Fetching article with ID: ${id}`);
    try {
      const response = await fetch(`${API_URL}/api/article_mytable/${id}`);
      if (!response.ok) {
        // Try to load sample data on specific failure like 404 or server error
        if (response.status === 404 || response.status >= 500) {
          console.warn(
            `Article ${id} not found or server error (${response.status}), loading sample data.`
          );
          setSelectedArticle(sampleArticle);
          setCurrentArticleId(sampleArticle.id); // Update ID to match sample
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
      // Load sample data as a fallback on fetch error
      setSelectedArticle(sampleArticle);
      setCurrentArticleId(sampleArticle.id); // Update ID to match sample
    } finally {
      setIsLoadingArticle(false);
    }
  }, []); // No dependencies needed here as ID is passed directly

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
        `${API_URL}/api/search_mytable?keyword=${encodeURIComponent(
          searchQuery.trim()
        )}`
      );
      if (!response.ok) {
        throw new Error(`Server returned ${response.status}`);
      }

      const data = await response.json();
      setArticles(data.articles || []);

      // Select first search result or keep current if there are no results
      if (data.articles?.length > 0) {
        setCurrentArticleId(data.articles[0].id);
      }
    } catch (error) {
      console.error("Error searching articles:", error);
      setErrorList(
        `Failed to search: ${error.message}. Please check if the API server is running.`
      );
      setArticles([]); // Clear articles on error
    } finally {
      setIsSearching(false);
    }
  }, [searchQuery, currentPage, fetchArticleList]);

  // Effect to load article list when page changes
  useEffect(() => {
    if (!isSearchMode) {
      fetchArticleList(currentPage);
    }
  }, [currentPage, fetchArticleList, isSearchMode]);

  // Effect to load specific article when ID changes
  useEffect(() => {
    fetchArticle(currentArticleId);
  }, [currentArticleId, fetchArticle]);

  // Handlers
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
