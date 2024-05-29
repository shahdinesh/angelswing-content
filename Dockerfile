FROM ruby:3.2.2

RUN apt-get update -qq \
  && apt-get install -y postgresql-client nodejs --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile
# COPY Gemfile.lock Gemfile.lock

RUN bundle install

# copy the whole app
COPY . /app
