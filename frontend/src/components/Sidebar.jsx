import React from "react";
import ArticleList from "./ArticleList";
import Pagination from "./Pagination";
import { Search } from "lucide-react";

function Sidebar({
  articles,
  currentArticleId,
  currentPage,
  totalPages,
  onSelectArticle,
  onPrevPage,
  onNextPage,
  isLoading,
  error,
  searchQuery,
  onSearchChange,
  onSearchSubmit,
  onClearSearch,
  isSearchMode,
  isSearching,
}) {
  return (
    <div className="w-[320px] h-[calc(100vh-70px)] fixed left-0 top-[70px] bg-paper border-r-4 border-primary overflow-y-auto p-6 shadow-md flex flex-col z-10 bg-[url('data:image/svg+xml,%3Csvg width='20' height='20' viewBox='0 0 20 20' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='%238b4513' fill-opacity='0.03'%3E%3Cpath d='M0 0h20v20H0V0zm10 17a7 7 0 1 0 0-14 7 7 0 0 0 0 14z'/%3E%3C/g%3E%3C/svg%3E')]">
      <form
        className="w-full relative mx-auto mb-6 pointer-events-auto border-b-2 border-border pb-4"
        onSubmit={onSearchSubmit}
      >
        <input
          type="text"
          value={searchQuery}
          onChange={onSearchChange}
          placeholder="Search in articles..."
          className="w-full py-2 px-4 pr-20 border-2 border-primary/30 rounded-lg focus:outline-none focus:border-primary transition-colors"
        />
        <div className="absolute right-3 top-1/2 -translate-y-1/2 flex items-center">
          <button
            type="submit"
            className="text-gray-500 hover:text-primary pointer-events-auto"
            disabled={isSearching}
          >
            <Search size={20} />
          </button>
          {isSearchMode && (
            <button
              type="button"
              onClick={onClearSearch}
              className="ml-2 text-sm px-1.5 py-0.5 bg-gray-100 hover:bg-gray-200 rounded-md transition-colors pointer-events-auto"
            >
              Clear
            </button>
          )}
        </div>
      </form>
      <div className="flex-grow overflow-y-auto mb-6 pr-2">
        {isLoading && (
          <div className="p-8 text-center text-secondary bg-paper border-l-3 border-primary">
            Loading articles...
          </div>
        )}
        {error && (
          <div className="p-8 text-center text-secondary bg-paper border-l-3 border-primary">
            {error}
          </div>
        )}
        {!isLoading && !error && (
          <ArticleList
            articles={articles}
            currentArticleId={currentArticleId}
            onSelectArticle={onSelectArticle}
          />
        )}
        {!isLoading && !error && articles.length === 0 && (
          <div className="p-8 text-center text-secondary bg-paper border-l-3 border-primary">
            No articles found for this page.
          </div>
        )}
      </div>
      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        onPrevPage={onPrevPage}
        onNextPage={onNextPage}
      />
    </div>
  );
}

export default Sidebar;
