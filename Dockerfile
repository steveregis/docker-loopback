FROM node:0.12
MAINTAINER Masato Shimizu <ma6ato@gmail.com>

RUN apt-get update && \
    apt-get install -y sudo && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN adduser --disabled-password --gecos '' --uid 1000 docker && \
  adduser docker sudo && \
  echo 'docker ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
  chown -R docker:docker /app

RUN npm install -g --unsafe-perm strongloop 
USER docker
ENTRYPOINT ["npm", "start"]
CMD []
