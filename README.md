# Docker Loopback

## Usage

Build Docker Image.

```sh
$ docker build -t loopback .
```

Run slc loopback command and create your app using loopback cli.

```sh
$ docker-compose run --rm slc loopback

     _-----_
    |       |    .--------------------------.
    |--(o)--|    |  Let's create a LoopBack |
   `---------´   |       application!       |
    ( _´U`_ )    '--------------------------'
    /___A___\
     |  ~  |
   __'.___.'__
 ´   `  |° ´ Y `

? What's the name of your application? (app) spike
```

After creating Loopback app, edit a docker-compose.yml working_dir directive wit created app name.

```yaml
slc: &defaults
  build: loopback
  volumes:
    - .:/app
  working_dir: /app/spike
  entrypoint: ["slc"]

server:
  <<: *defaults
  entrypoint: ["slc","run"]
  ports:
    - "3000:3000"
```

Now up server service.

```sh
$ docker-compose up server
```

## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

[Masato Shimizu](https://github.com/masato)
