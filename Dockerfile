FROM node:10-slim

RUN apt-get update && \
  apt-get install -y bzip2 libfontconfig libfreetype6 jq python build-essential git rsync curl && \
  apt-get clean && \
  # Global npm packages
  npm install -g concurrently lerna
