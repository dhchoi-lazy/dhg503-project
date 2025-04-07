import React from "react";
import { ChevronLeft, ChevronRight } from "lucide-react";

function Pagination({ currentPage, totalPages, onPrevPage, onNextPage }) {
  return (
    <div className="flex items-center justify-between pt-6 border-t-2 border-border flex-shrink-0">
      <button
        onClick={onPrevPage}
        disabled={currentPage <= 1}
        aria-label="Previous Page"
        className="p-2 rounded-none border border-border bg-paper text-primary transition-all duration-300 flex items-center justify-center disabled:opacity-50 disabled:cursor-not-allowed enabled:hover:bg-primary enabled:hover:text-paper"
      >
        <ChevronLeft />
      </button>
      <span className="text-sm text-text font-medium">
        Page {currentPage} of {totalPages}
      </span>
      <button
        onClick={onNextPage}
        disabled={currentPage >= totalPages}
        aria-label="Next Page"
        className="p-2 rounded-none border border-border bg-paper text-primary transition-all duration-300 flex items-center justify-center disabled:opacity-50 disabled:cursor-not-allowed enabled:hover:bg-primary enabled:hover:text-paper"
      >
        <ChevronRight />
      </button>
    </div>
  );
}

export default Pagination;
