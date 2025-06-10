# Base image for building
FROM node:20-alpine AS builder

# Working dir
WORKDIR /slgvd_frontend

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Base image for serving
FROM nginx:stable-alpine

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d


COPY --from=builder /slgvd_frontend/dist/ /usr/share/nginx/html

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
