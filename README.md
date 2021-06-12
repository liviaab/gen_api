# GenAPI
[Repository for learning purposes]

- This is a simple api application, composed by a single root `/` endpoint, a genserver (`UserServer`), and a single `User` module.
- A `User` will have an `id`, `points` (integer field that accepts any number between 0 and 100) and `timestamps`.
- When the root endpoint receives a request, an action should call the genserver and return the result. Example of the request/response flow: 
	- [api] <-> [genserver] <-> [database]

- Request/Response format example:
`GET localhost:3000/`

```elixir
{
  'users': [{id: 1, points: 30}, {id: 72, points: 30}],
  'timestamp': `2020-07-30 17:09:33`
}
```

- For more information about the specifications, send me a message :)

### Requirements
- `elixir 1.12` 
- `erlang 24.0` 
- `postgres 12.7`


### Running
First of all, clone the repository
```sh
$ git clone git@github.com:liviaab/gen_api.git
$ cd gen_api
```

You can run the application locally or using docker-compose (v1.29.2). In both ways, the app will start at [http://localhost:3000](http://localhost:3000)

##### Locally
Before running the application, you should change the database configuration (username, password and hostname in `./config/dev.exs`) to your local postgres database configurations. Then you can run the following commands in Terminal:

```sh
$ mix ecto.setup	# creates the database, runs migration and seeds
$ mix phx.server	# starts the server

```

##### With Docker
No changes needed, all the config files are set to docker settings.
```sh
$ docker-compose build
$ docker-compose run api mix ecto.setup
$ docker-compose up -d

```

To stop the container:
```sh
$ docker-compose down

```

### Running Tests Locally
Before running the tests locally, you should change the database configuration (username, password and hostname in `./config/test.exs`) to your local postgres database configurations. Than you can:

```sh
$ mix test
```

