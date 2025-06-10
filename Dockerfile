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

COPY --from=builder /slgvd_frontend/dist/ /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
