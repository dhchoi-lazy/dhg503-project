import React from "react";

const ExternalLinkIcon = () => (
  <svg
    width="16"
    height="16"
    viewBox="0 0 24 24"
    fill="none"
    stroke="currentColor"
    strokeWidth="2"
    strokeLinecap="round"
    strokeLinejoin="round"
  >
    <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6" />
    <polyline points="15 3 21 3 21 9" />
    <line x1="10" y1="14" x2="21" y2="3" />
  </svg>
);

// Common container component for the paper-like appearance
const PaperContainer = ({ children }) => (
  <div className="ml-[320px] p-8 min-h-screen mx-auto">
    <div className="max-w-2xl mx-auto bg-paper p-10 shadow-md relative border-l-2 border-r-2 border-border before:content-[''] before:absolute before:left-0 before:top-0 before:bottom-0 before:w-px before:bg-[repeating-linear-gradient(to_bottom,var(--border),var(--border)_2px,transparent_2px,transparent_10px)] after:content-[''] after:absolute after:right-0 after:top-0 after:bottom-0 after:w-px after:bg-[repeating-linear-gradient(to_bottom,var(--border),var(--border)_2px,transparent_2px,transparent_10px)]">
      {children}
    </div>
  </div>
);

// Footer component reused across different states
const PageFooter = () => (
  <footer className="text-center mt-12 py-6 text-secondary text-sm font-medium border-t-2 border-border bg-primary/[0.03] relative before:content-[''] before:absolute before:left-1/2 before:top-[-15px] before:-translate-x-1/2 before:w-[30px] before:h-[30px] before:bg-paper before:border-2 before:border-border before:rounded-full">
    <p>明清實錄 • Ming Qing Shilu</p>
  </footer>
);

// Message box for displaying messages with consistent styling
const MessageBox = ({ children }) => (
  <div className="p-8 text-center text-secondary bg-paper border-l-3 border-primary mb-4">
    {children}
  </div>
);

// Loading state component
const LoadingState = () => (
  <div className="ml-[320px] p-8 min-h-screen w-[calc(100%)] mx-auto">
    <div className="max-w-3xl mx-auto bg-paper p-10 shadow-md relative border-l-2 border-r-2 border-border before:content-[''] before:absolute before:left-0 before:top-0 before:bottom-0 before:w-px before:bg-[repeating-linear-gradient(to_bottom,var(--border),var(--border)_2px,transparent_2px,transparent_10px)] after:content-[''] after:absolute after:right-0 after:top-0 after:bottom-0 after:w-px after:bg-[repeating-linear-gradient(to_bottom,var(--border),var(--border)_2px,transparent_2px,transparent_10px)]">
      <MessageBox>Loading article...</MessageBox>
    </div>
  </div>
);

// Article metadata display
const ArticleMetadata = ({ id, year, date }) => (
  <div className="grid grid-cols-3 gap-6 bg-primary/5 p-6 mb-12 border-l-3 border-primary relative before:content-[''] before:absolute before:inset-0 before:bg-[url('data:image/svg+xml,%3Csvg width='20' height='20' viewBox='0 0 20 20' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='%238b4513' fill-opacity='0.03'%3E%3Cpath d='M0 0h20v20H0V0zm10 17a7 7 0 1 0 0-14 7 7 0 0 0 0 14z'/%3E%3C/g%3E%3C/svg%3E')] before:-z-10">
    <MetadataItem label="Document ID" value={id} />
    <MetadataItem label="Year" value={year} />
    <MetadataItem label="Date" value={date} />
  </div>
);

// Individual metadata item
const MetadataItem = ({ label, value }) => (
  <div className="text-center relative">
    <span className="block text-sm text-secondary mb-2 font-medium">
      {label}
    </span>
    <span className="text-xl font-semibold text-primary min-h-[1.5em]">
      {value || "N/A"}
    </span>
  </div>
);

// Article header component
const ArticleHeader = ({ title, king }) => (
  <header className="text-center mb-12 relative pb-6 after:content-[''] after:absolute after:bottom-0 after:left-1/2 after:-translate-x-1/2 after:w-[100px] after:h-0.5 after:bg-primary">
    <h1 className="text-4xl font-bold text-primary mb-4 drop-shadow-sm tracking-wide">
      {title || "No Title"}
    </h1>
    <p className="text-2xl text-secondary font-medium">{king || ""}</p>
  </header>
);

// Article content component
const ArticleContentDisplay = ({ content }) => (
  <div className="bg-paper p-8 mb-8 border-l-3 border-primary relative before:content-[''] before:absolute before:top-0 before:bottom-0 before:left-[40px] before:w-px before:bg-primary/10">
    <p className="whitespace-pre-wrap leading-9 text-text text-lg min-h-[5em] text-justify relative pl-12 first-letter:text-3xl first-letter:text-primary first-letter:font-semibold">
      {content || "No content available."}
    </p>
  </div>
);

// Original source link component
const SourceLink = ({ url }) =>
  url ? (
    <a
      href={url}
      className="inline-flex items-center text-primary no-underline transition-all duration-300 py-2 px-4 border border-border border-l-3 border-l-primary bg-primary/5 hover:bg-primary hover:text-paper"
      target="_blank"
      rel="noopener noreferrer"
    >
      View Original Source
      <span className="ml-2">
        <ExternalLinkIcon />
      </span>
    </a>
  ) : null;

// Full article display component
const ArticleDisplay = ({ article, error }) => (
  <PaperContainer>
    {error && <MessageBox>{error}</MessageBox>}

    <ArticleHeader title={article.title} king={article.king} />
    <ArticleMetadata id={article.id} year={article.year} date={article.date} />
    <ArticleContentDisplay content={article.content} />
    <SourceLink url={article.url} />
    <PageFooter />
  </PaperContainer>
);

// Empty state component
const EmptyState = () => (
  <PaperContainer>
    <MessageBox>Select an article from the sidebar.</MessageBox>
    <PageFooter />
  </PaperContainer>
);

// Error state component for when no article could be loaded
const ErrorState = ({ error }) => (
  <div className="ml-[320px] p-8 min-h-screen w-[calc(100%)] mx-auto">
    <div className="max-w-3xl mx-auto bg-paper p-10 shadow-md relative border-l-2 border-r-2 border-border before:content-[''] before:absolute before:left-0 before:top-0 before:bottom-0 before:w-px before:bg-[repeating-linear-gradient(to_bottom,var(--border),var(--border)_2px,transparent_2px,transparent_10px)] after:content-[''] after:absolute after:right-0 after:top-0 after:bottom-0 after:w-px after:bg-[repeating-linear-gradient(to_bottom,var(--border),var(--border)_2px,transparent_2px,transparent_10px)]">
      <MessageBox>{error}</MessageBox>
      <PageFooter />
    </div>
  </div>
);

// Main component
function MainContent({ article, isLoading, error }) {
  if (isLoading) {
    return <LoadingState />;
  }

  if (error && !article) {
    return <ErrorState error={error} />;
  }

  if (!article) {
    return <EmptyState />;
  }

  return <ArticleDisplay article={article} error={error} />;
}

export default MainContent;
