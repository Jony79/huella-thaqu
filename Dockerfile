FROM node:22-alpine AS app-build
WORKDIR /src/app
COPY app/package.json app/package-lock.json* ./
RUN npm install
COPY app/ ./
RUN npm run build

FROM node:22-alpine
WORKDIR /srv
ENV NODE_ENV=production
COPY server/package.json server/package-lock.json* ./
RUN npm install --omit=dev
COPY server/ ./
COPY content ./content
COPY material/Nomina ./material/Nomina
COPY --from=app-build /src/app/dist ./public
RUN mkdir -p /srv/uploads
EXPOSE 3000
CMD ["node", "src/index.js"]
