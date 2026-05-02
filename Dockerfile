FROM ruby:3.4-slim

RUN gem install jekyll:4.4.1 webrick:1.9.2 --no-document

WORKDIR /site
EXPOSE 4000

CMD ["jekyll", "serve", "--host", "0.0.0.0", "--watch", "--force_polling"]
