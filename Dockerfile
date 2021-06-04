
FROM bitwalker/alpine-elixir-phoenix:latest

WORKDIR /app

COPY . .
RUN mix do deps.get, deps.compile, compile