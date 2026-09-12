import { existsSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import cors from "cors";
import express from "express";
import { pool } from "./db.js";
import { migrate } from "./migrate.js";
import { registerRoutes } from "./routes.js";

const here = dirname(fileURLToPath(import.meta.url));
const publicDir = join(here, "../public");
const uploadsDir = process.env.UPLOADS_DIR || join(here, "../uploads");

const app = express();
app.use(cors());
app.use(express.json({ limit: "2mb" }));
app.use("/uploads", express.static(uploadsDir));

registerRoutes(app);

if (existsSync(publicDir)) {
  app.use(express.static(publicDir));
  app.use((req, res, next) => {
    if (req.method !== "GET" || req.path.startsWith("/api") || req.path.startsWith("/uploads")) {
      next();
      return;
    }
    res.sendFile(join(publicDir, "index.html"));
  });
}

const port = Number(process.env.PORT || 3000);

async function start() {
  await migrate();
  app.listen(port, "0.0.0.0", () => {
    console.log(`Huella Thaqu en puerto ${port}`);
  });
}

start().catch((error) => {
  console.error(error);
  process.exit(1);
});

process.on("SIGTERM", async () => {
  await pool.end();
  process.exit(0);
});
