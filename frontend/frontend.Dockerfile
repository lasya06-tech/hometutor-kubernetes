FROM node:20-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm install

# Copy source AFTER node_modules is installed
COPY . .

# FIX: Apply executable permission AFTER final copy
RUN chmod -R +x node_modules/.bin

RUN npm run build

FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]