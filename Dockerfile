# syntax = docker/dockerfile:1

FROM ruby:3.3.4-slim

# Rails app lives here
WORKDIR /app

ARG UID=1000
ARG GID=1000

# Install base packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      curl \
      git \
      libpq-dev \
      libgit2-dev \
      cmake \
      pkg-config && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man && \
    apt-get clean && \
    groupadd -g "$GID" ruby && \
    useradd --create-home --no-log-init -u "$UID" -g "$GID" ruby

USER ruby

COPY --chown=ruby:ruby Gemfile* ./
RUN bundle install

ENV RAILS_ENV=development \
    PATH="/home/ruby/.local/bin:${PATH}" \
    USER="ruby"

COPY --chown=ruby:ruby . .

EXPOSE 3000

CMD ["rails", "s"]
