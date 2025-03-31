import React from "react";

// SVG Icons as React Components (improves reusability and clarity)
const ChevronLeftIcon = () => (
  <svg
    width="20"
    height="20"
    viewBox="0 0 24 24"
    fill="none"
    stroke="currentColor"
    strokeWidth="2"
    strokeLinecap="round"
    strokeLinejoin="round"
  >
    <path d="m15 18-6-6 6-6" />
  </svg>
);

const ChevronRightIcon = () => (
  <svg
    width="20"
    height="20"
    viewBox="0 0 24 24"
    fill="none"
    stroke="currentColor"
    strokeWidth="2"
    strokeLinecap="round"
    strokeLinejoin="round"
  >
    <path d="m9 18 6-6-6-6" />
  </svg>
);

function Pagination({ currentPage, totalPages, onPrevPage, onNextPage }) {
  return (
    <div className="flex items-center justify-between pt-6 border-t-2 border-border flex-shrink-0">
      <button
        onClick={onPrevPage}
        disabled={currentPage <= 1}
        aria-label="Previous Page"
        className="p-2 rounded-none border border-border bg-paper text-primary transition-all duration-300 flex items-center justify-center disabled:opacity-50 disabled:cursor-not-allowed enabled:hover:bg-primary enabled:hover:text-paper"
      >
        <ChevronLeftIcon />
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
        <ChevronRightIcon />
      </button>
    </div>
  );
}

export default Pagination;
