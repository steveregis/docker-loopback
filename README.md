# Docker Loopback

## Install

Build Docker Image.

```sh
$ docker build -t loopback .
```

Run slc loopback command and create your app (in this case spike-todo) using loopback cli.

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

? What's the name of your application? spike-todo
   create spike-todo/
     info change the working directory to spike-todo
...
Next steps:

  Change directory to your app
    $ cd spike-todo

  Create a model in your app
    $ slc loopback:model

  Optional: Enable StrongOps monitoring
    $ slc strongops

  Run the app
    $ slc run .

Removing dockerloopback_slc_run_1...
```

## App Setting

After creating Loopback app, edit a docker-compose.yml working_dir directive wit created app name.

```yaml
slc: &defaults
  image: loopback
  volumes:
    - .:/app
  working_dir: /app/spike-todo
  links:
    - mongo
  entrypoint: ["slc"]
server:
  <<: *defaults
  entrypoint: ["slc","run"]
  ports:
    - "3000:3000"
npm:
  <<: *defaults
  entrypoint: ["npm"]
mongo:
  image: mongo
  volumes:
    - ./mongo:/data/db
```

### MondoDB Connector

Using npm service defined in docker-compose.yml, install loopback-connector-mongodb package.

```sh
$ docker-compose run --rm npm install loopback-connector-mongodb --save
...
loopback-connector-mongodb@1.11.0 node_modules/loopback-connector-mongodb
├── debug@2.2.0 (ms@0.7.1)
├── loopback-connector@2.2.1
├── async@1.2.1
└── mongodb@2.0.33 (readable-stream@1.0.31, mongodb-core@1.1.32)
Removing dockerloopback_npm_run_1...
```

Edit `server/datasources.json` in app supplying MongoDB information.

``json
{
  "db": {
    "name": "db",
    "connector": "memory"
  },
  "mongodb_dev": {
    "host": "mongo",
    "port": 27017,
    "database": "devDB",
    "username": "devUser",
    "password": "",
    "name": "",
    "connector": "mongodb"
  }
}
```

### Create Model

The next step is create a database Model. 

```sh
$ $ docker-compose run --rm slc  loopback:model
? Enter the model name: Todo
? Select the data-source to attach Todo to: mongodb_dev (mongodb)
? Select model's base class: PersistedModel
? Expose Todo via the REST API? Yes
? Custom plural form (used to build REST URL): Todos
Let's add some Todo properties now.

Enter an empty property name when done.
? Property name: title
   invoke   loopback:property
? Property type: string
? Required? Yes

Let's add another Todo property.
Enter an empty property name when done.
? Property name: completed
   invoke   loopback:property
? Property type: boolean
? Required? No

Let's add another Todo property.
Enter an empty property name when done.
? Property name:
Removing dockerloopback_slc_run_1...
```

Up a server service and visit the following url http://xxx..xxx.xxx:3000/explorer with Docker Host IP address.

```sh
$ docker-compose up server
Creating dockerloopback_mongo_1...
Creating dockerloopback_server_1...
Attaching to dockerloopback_server_1
server_1 | INFO strong-agent v1.6.0 profiling app 'spike-todo' pid '1'
server_1 | INFO strong-agent[1] started profiling agent
server_1 | INFO supervisor reporting metrics to `internal:`
server_1 | supervisor running without clustering (unsupervised)
server_1 | INFO strong-agent not profiling, agent metrics requires a valid license.
server_1 | Please contact sales@strongloop.com for assistance.
server_1 | Browse your REST API at http://0.0.0.0:3000/explorer
server_1 | Web server listening at: http://0.0.0.0:3000/
```

## REST API Examples

Status

```bash
$ curl http://localhost:3000
{"started":"2015-06-09T02:31:05.307Z","uptime":37.229}
```

POST record

```js
$ curl -X POST -H "Content-Type:application/json" \
-d '{"title": "サンプル", "completed": false}' \
http://localhost:3000/api/ToDos
{"title":"サンプル","completed":false,"id":"55766dcba3148801001e6e42"}
```

GET records

```sh
$ curl -X GET localhost:3000/api/Todos?filter=%7B%22where%22%3A%7B%22title%22%3A%22%E3%82%B5%E3%83%B3%E3%83%97%E3%83%AB%22%7D%7D
[{"title":"サンプル","completed":false,"id":"55766dcba3148801001e6e42"}]
```

This query string is URL encoded from a JSON format criteria below.

```js
{"where":{"title":"サンプル"}}
```

Enter a MongoDB container and ensure that new record created.

```sh
$ docker exec -it dockerloopback_mongo_1 mongo devDB
MongoDB shell version: 3.0.3
connecting to: devDB
> db.Todo.find({title:"サンプル"});
{ "_id" : ObjectId("55766dcba3148801001e6e42"), "title" : "サンプル", "completed" : false }
```

## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

[Masato Shimizu](https://github.com/masato)
