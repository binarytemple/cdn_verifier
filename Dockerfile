FROM elixir:1.12.1-alpine AS base

ENV MIX_ENV=prod

WORKDIR /app

RUN apk upgrade && apk update

RUN mix local.hex --force && mix local.rebar --force

COPY mix.* ./

RUN mix do deps.get, deps.compile 

COPY config/* config/

COPY lib lib

RUN mix compile 

RUN mix release

RUN MIX_ENV=prod mix compile

COPY ./rel ./rel

COPY config/runtime.exs config/runtime.exs

RUN MIX_ENV=prod mix release > /dev/null

FROM alpine:3.12 AS release

LABEL org.opencontainers.image.source https://github.com/binarytemple/cdn_verifier

WORKDIR /app

RUN apk upgrade && apk add --update --no-cache openssl ncurses-libs libgcc libstdc++

COPY --from=base /app/_build/prod/rel/cdn_verifier/ .

RUN find /app -type f -perm +0100 -exec chmod 555 {} \;

ENV MONDAY_API_TOKEN ""
ENV PORT 80
ENV SECURE_PORT 443

ENTRYPOINT ["./bin/cdn_verifier"]

CMD ["start"]