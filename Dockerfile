FROM ruby:2.4.3

ENV BUILD_ROOT /build
ENV APP_ROOT /app

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir ${BUILD_ROOT} 
RUN mkdir ${APP_ROOT}
COPY myapp/Gemfile ${BUILD_ROOT}/Gemfile
COPY myapp/Gemfile.lock ${BUILD_ROOT}/Gemfile.lock

WORKDIR ${BUILD_ROOT}
RUN bundle install

WORKDIR ${APP_ROOT}
