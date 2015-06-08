FROM node:0.12
MAINTAINER Masato Shimizu <ma6ato@gmail.com>

RUN apt-get update && apt-get install -y sudo sudo  && \
  rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app/usr/local/lib/
WORKDIR /app
COPY package.json /app/

RUN adduser --disabled-password --gecos '' --uid 1000 docker && \
  adduser docker sudo && \
  echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
  chown -R docker:docker /app

USER docker
ENV PATH /dist/usr/local/bin:$PATH

RUN sudo mkdir -p /dist/app/node_modules /dist/usr/local  && \
    sudo ln -s /dist/app/node_modules /app/node_modules && \
    sudo ln -s /dist/usr/local/lib/node_modules  /app/usr/local/lib/node_modules &&\
    sudo npm config set prefix /dist/usr/local && \
    sudo npm install -g --unsafe-perm  strongloop 

COPY . /app
EXPOSE 3000
ENTRYPOINT ["npm", "start"]
CMD []
