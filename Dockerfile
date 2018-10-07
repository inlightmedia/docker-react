# MultiStep Build Process
# WE ARE CALLING THIS BUILD PHASE builder SO THAT WE CAN REFERENCE IT LATER
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# USING FROM AGAIN SAYS WE ARE STARTING A NEW PHASE
FROM nginx
EXPOSE 80 
# Exposing port 80 here does nothing usually. However, this is used by Elastic Beanstalk to expose port 80 for nginx
# --from=builder is required to reach into the last build step and grab that build folder
COPY --from=builder /app/build /usr/share/nginx/html