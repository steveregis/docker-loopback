# Docker Loopback (Experimental)

## Usage

Make simlinks and directory in a docker cloned directory.

```sh
$ mkdir -p ./app/usr/local/lib
$ ln -s /dist/app/node_modules .
$ ln -s /dist/usr/local/lib/node_modules ./app/usr/local/lib
```

Build Docker Image.

```sh
$ docker build -t loopback .
```

Run slc loopback command.

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

? What's the name of your application? (app)
```

## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

[Masato Shimizu](https://github.com/masato)
