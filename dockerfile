FROM ruby:2.3.8-alpine3.8

WORKDIR /app
COPY . /app/

# install gems to /gems folder
ENV BUNDLE_PATH /gems

# set to production
ENV RAILS_ENV=production

# install necessary version of bundler
RUN gem install bundler:1.11.2

# install build deps /  gems
RUN apk update; \
  apk add --no-cache --virtual builddeps build-base libxml2-dev libxslt-dev; \
  apk add --no-cache ruby-nokogiri sqlite-dev tzdata curl; \  
  bundle config build.nokogiri --use-system-libraries; \
  bundle install --without development test; \
  apk del builddeps


# install supercronic
ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.1.12/supercronic-linux-arm64 \
    SUPERCRONIC=supercronic-linux-arm64 \
    SUPERCRONIC_SHA1SUM=8baba3dd0b0b13552aca179f6ef10d55e5dee28b

RUN curl -fsSLO "$SUPERCRONIC_URL" \
 && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
 && chmod +x "$SUPERCRONIC" \
 && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
 && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic

RUN bundle exec whenever --update-crontab

RUN chmod +x ./start.sh

# run server when container is started
CMD ["./start.sh"]

# expose server port
EXPOSE 3000
