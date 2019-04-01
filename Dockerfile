FROM node:10-slim

RUN apt-get update && \
  apt-get install -y \
    build-essential \
    bzip2 \
    curl \
    git \
    jq \
    libfontconfig \
    libfreetype6 \
    python \
    rsync \
    zip && \
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
