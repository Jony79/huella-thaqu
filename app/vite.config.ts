import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { VitePWA } from "vite-plugin-pwa";

export default defineConfig({
  plugins: [
    react(),
    VitePWA({
      registerType: "autoUpdate",
      includeAssets: ["favicon.svg", "insignias/*", "icons/*", "insignias/completa.png"],
      manifest: {
        name: "Huella Thaqu",
        short_name: "Thaqu",
        description: "Progresión de protagonistas Caminantes",
        start_url: "/",
        display: "standalone",
        background_color: "#e7f6fc",
        theme_color: "#3db7e4",
        lang: "es-AR",
        icons: [
          { src: "/icons/icon.svg", sizes: "any", type: "image/svg+xml", purpose: "any" },
          { src: "/icons/icon.svg", sizes: "any", type: "image/svg+xml", purpose: "maskable" },
        ],
      },
      workbox: {
        navigateFallback: "/index.html",
        runtimeCaching: [
          {
            urlPattern: /\/api\//,
            handler: "NetworkOnly",
          },
          {
            urlPattern: /\/uploads\//,
            handler: "StaleWhileRevalidate",
          },
        ],
      },
    }),
  ],
  server: {
    port: 5173,
    proxy: {
      "/api": "http://127.0.0.1:3000",
      "/uploads": "http://127.0.0.1:3000",
    },
  },
});
