FROM ruby:3.1.2-slim
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    less \
    git \
    telnet \
    nodejs \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update -qq && apt-get install -y default-libmysqlclient-dev

#Cache bundle install
WORKDIR /tmp
RUN gem install rails
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN bundle install

ENV APP_ROOT /workspace
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
COPY . $APP_ROOT

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    BUNDLE_JOBS=2 \
    GEM_HOME=/bundle \
    BUNDLE_GEMFILE=/workspace/Gemfile

ENV PATH="${BUNDLE_BIN}:${PATH}"

ENTRYPOINT ["./docker_entrypoint.sh"]
