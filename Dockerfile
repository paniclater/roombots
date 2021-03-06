FROM hqmq/docker-elixir:1.1.1.0
MAINTAINER Michael Ries <michael@riesd.com>

EXPOSE 4000

ADD . /roombots
WORKDIR /roombots
RUN mix clean
RUN mix local.hex --force
RUN mix local.rebar --force
RUN MIX_ENV=prod mix deps.get --only prod
RUN MIX_ENV=prod mix compile
RUN MIX_ENV=prod mix phoenix.digest

CMD PORT=4000 MIX_ENV=prod mix phoenix.server
