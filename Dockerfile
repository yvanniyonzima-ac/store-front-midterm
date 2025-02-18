# Build the Vue.js app
FROM node:20 AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ENV VUE_APP_ORDER_SERVICE_URL=https://order-service.fake.net
ENV VUE_APP_PRODUCT_SERVICE_URL=https://product-service.fake.net
RUN npm run build

# Nginx for serving the built app
FROM nginx:alpine
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80