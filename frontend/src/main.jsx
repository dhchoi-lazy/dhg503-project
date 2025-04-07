import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { BrowserRouter } from "react-router-dom";
import "./index.css";
import App from "./App.jsx";

const fontLink = document.createElement("link");
fontLink.rel = "stylesheet";
fontLink.href =
  "https://fonts.googleapis.com/css2?family=Noto+Serif+SC:wght@400;500;600;700&display=swap";
document.head.appendChild(fontLink);

document.body.classList.add(
  "font-serif",
  "bg-background",
  "text-text",
  "leading-7"
);

// Ensure styles are applied
document.documentElement.style.setProperty("--primary", "#8b4513");
document.documentElement.style.setProperty("--secondary", "#d2691e");
document.documentElement.style.setProperty("--accent", "#cd853f");
document.documentElement.style.setProperty("--background", "#f5e8c9");
document.documentElement.style.setProperty("--paper", "#f9f2e3");
document.documentElement.style.setProperty("--text", "#2d1810");
document.documentElement.style.setProperty("--border", "#c8ad8d");
document.documentElement.style.setProperty("--red-seal", "#a02c2c");

createRoot(document.getElementById("root")).render(
  <StrictMode>
    <BrowserRouter>
      <App />
    </BrowserRouter>
  </StrictMode>
);
