FROM node:0.12
MAINTAINER Masato Shimizu <ma6ato@gmail.com>

RUN mkdir -p /app
WORKDIR /app
RUN mkdir -p /dist/node_modules && \
    ln -s /dist/node_modules /app/node_modules && \
    npm install -g --unsafe-perm  strongloop 
COPY . /app
ENTRYPOINT ["npm", "start"]
CMD []
