/**
 * Helper function to determine API URL
 * Uses relative paths with the proxy in development
 * Uses environment variables in production
 */
const getApiUrl = (path) => {
  // Remove leading slash if present
  const cleanPath = path.startsWith("/") ? path.substring(1) : path;

  // In development with Vite proxy
  if (import.meta.env.DEV) {
    return `/api/${cleanPath}`;
  }

  // In production, use the environment variable
  const baseUrl = import.meta.env.VITE_API_BASE_URL || "";
  return `${baseUrl}/${cleanPath}`;
};

export { getApiUrl };
