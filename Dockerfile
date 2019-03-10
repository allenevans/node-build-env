FROM node:10-slim

RUN apt-get update && \
  apt-get install -y bzip2 libfontconfig libfreetype6 jq python build-essential git rsync curl && \
  apt-get clean && \
  # Global npm packages
  npm install -g concurrently lerna typescript serverless

RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
  sh get-docker.sh

RUN curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

RUN base=https://github.com/docker/machine/releases/download/v0.16.1 && \
      curl -L $base/docker-machine-$(uname -s)-$(uname -m) > /tmp/docker-machine && \
      install /tmp/docker-machine /bin/docker-machine

COPY ./src /
