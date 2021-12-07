#
# STAGE ONE
FROM node:16-alpine3.12 AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
#RUN export NODE_OPTIONS=--openssl-legacy-provider && yarn build && yarn install --production --ignore-scripts --prefer-offline
COPY . .
RUN npm run build

#
# STAGE TWO
# https://hub.docker.com/_/nginx
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# nginx startsitself so no RUN statement needed
