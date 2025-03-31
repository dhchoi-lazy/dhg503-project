import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig(({ command }) => {
  if (command === "serve") {
    return {
      plugins: [react()],
      server: {
        allowedHosts: true,
        proxy: {
          "/api": {
            target: "http://localhost:8000",
            changeOrigin: true,
          },
        },
      },
      define: {
        "import.meta.env.VITE_API_BASE_URL": JSON.stringify(""),
      },
    };
  } else {
    return {
      plugins: [react()],
      server: {
        allowedHosts: true,
        proxy: {
          "/api": {
            target: "http://api:8000",
            changeOrigin: true,
          },
        },
      },
      define: {
        "import.meta.env.VITE_API_BASE_URL": JSON.stringify("http://api:8000"),
      },
    };
  }
});
