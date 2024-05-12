FROM node:current-alpine3.18 as builder
WORKDIR '/app'
COPY package.json .
RUN npm install --loglevel verbose
COPY ./ ./
RUN npm run build

FROM node:current-alpine3.18 
WORKDIR '/app'
COPY --from=builder /app/build /app/build
RUN npm install -g serve --loglevel verbose
CMD ["serve", "-s", "build"]
