FROM ruby:2.4.3

ENV BUILD_ROOT /build
ENV APP_ROOT /web

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir ${BUILD_ROOT} && \
    mkdir ${APP_ROOT}

COPY myapp/Gemfile ${BUILD_ROOT}/Gemfile
COPY myapp/Gemfile.lock ${BUILD_ROOT}/Gemfile.lock

WORKDIR ${BUILD_ROOT}
RUN bundle install

WORKDIR ${APP_ROOT}

RUN useradd -m web && \
    mkdir -p ${APP_ROOT}/tmp && \
    chown web:web ${APP_ROOT}/tmp

VOLUME ["${APP_ROOT}/tmp"]

USER web

WORKDIR ${APP_ROOT}
