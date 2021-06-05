
FROM bitwalker/alpine-elixir-phoenix:latest

WORKDIR /app

COPY . .
RUN mv ./config/dev.exs.example ./config/dev.exs
RUN mv ./config/test.exs.example ./config/test.exs
RUN mix do deps.get, deps.compile, compile