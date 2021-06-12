
FROM elixir:latest

WORKDIR /app

ENV MIX_ENV=dev

COPY . .
RUN rm -rf ./_build

RUN wget https://s3.amazonaws.com/rebar3/rebar3 && chmod +x rebar3
RUN mix local.rebar rebar3 ./rebar3

RUN mix local.hex --force
RUN HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=180 mix do deps.clean --all, clean, deps.get, deps.compile, compile