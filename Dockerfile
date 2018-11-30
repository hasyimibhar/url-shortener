FROM ruby:2.3.7-slim

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Make sure bundler is up-to-date
RUN gem install bundler

RUN mkdir /app

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install
COPY . /app

EXPOSE 3000
CMD ["puma"]
