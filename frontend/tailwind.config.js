/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  safelist: [
    // Add color classes that might be used in template literals or dynamic classes
    "text-primary",
    "bg-primary",
    "border-primary",
    "text-secondary",
    "bg-secondary",
    "border-secondary",
    "text-accent",
    "bg-accent",
    "border-accent",
    "text-background",
    "bg-background",
    "border-background",
    "text-paper",
    "bg-paper",
    "border-paper",
    "text-text",
    "bg-text",
    "border-text",
    "text-border",
    "bg-border",
    "border-border",
    "text-red-seal",
    "bg-red-seal",
    "border-red-seal",
  ],
  theme: {
    extend: {
      colors: {
        primary: "#8b4513",
        secondary: "#d2691e",
        accent: "#cd853f",
        background: "#f5e8c9",
        paper: "#f9f2e3",
        text: "#2d1810",
        border: "#c8ad8d",
        "red-seal": "#a02c2c",
      },
      fontFamily: {
        sans: ["system-ui", "Avenir", "Helvetica", "Arial", "sans-serif"],
        serif: ["Noto Serif SC", "STSong", "serif"],
      },
      borderWidth: {
        3: "3px",
      },
    },
  },
  plugins: [],
};
