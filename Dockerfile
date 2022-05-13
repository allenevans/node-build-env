FROM node:16-slim

# https://github.com/docker/compose/releases
ARG DOCKER_COMPOSE_VERSION=2.5.0

# https://github.com/actions/runner/releases
ARG GITHUB_RUNNER_VERSION=2.291.1

# https://github.com/docker/machine/releases
ARG DOCKER_MACHINE_VERSION=0.16.2

# https://www.terraform.io/downloads.html
ARG TERRAFORM_VERSION=1.1.9

RUN apt-get update && \
  apt-get install -y \
    apt-transport-https \
        autoconf \
        build-essential \
        bzip2 \
        ca-certificates \
        curl \
        default-mysql-client \
        git \
        jq \
        libglu1-mesa \
        libicu-dev \
        libxi6 \
        libxrender1 \
        libxtst6 \
        python3 \
        python3-pip \
        python3-setuptools \
        software-properties-common \
        sudo \
        supervisor \
        unzip \
        zip;

RUN pip3 install awscli --upgrade;

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
  apt-get install -y --no-install-recommends git-lfs && \
  apt-get clean && \
  rm -r /var/lib/apt/lists/*;
# Global npm packages
RUN npm -v;\
    npm install -g \
        concurrently \
        lerna \
        npm \
        serverless \
        typescript

# Install Docker CLI
RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh && rm get-docker.sh

# Install Docker-Compose
RUN curl -L "https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Install docker machine
RUN base=https://github.com/docker/machine/releases/download/v${DOCKER_MACHINE_VERSION} && \
      curl -L $base/docker-machine-$(uname -s)-$(uname -m) > /tmp/docker-machine && \
      install /tmp/docker-machine /bin/docker-machine

# Install terraform
RUN curl -L -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

COPY ./src /
