FROM node:8-slim

RUN apt-get update && \
  apt-get install -y bzip2 libfontconfig libfreetype6 jq python build-essential git rsync && \
  apt-get clean && \
  # Global npm packages
  npm install -g concurrently lerna

