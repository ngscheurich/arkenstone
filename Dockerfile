FROM ruby:2.2.3

RUN apt-get update -qq

ENV APP_DIR /app
RUN mkdir $APP_DIR
WORKDIR $APP_DIR

ADD . $APP_DIR
RUN bundle install