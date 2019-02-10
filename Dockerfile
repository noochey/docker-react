#Use existing image as base
FROM node:alpine as builder

WORKDIR '/app'

#download and install dependency
COPY package.json .
RUN npm install
COPY . .

#tell image what to do
RUN npm run build

#/app/build/ contains all teh stuff we need

FROM nginx
#for elastic beanstalk for incoming traffic
EXPOSE 80 
COPY --from=builder /app/build /usr/share/nginx/html