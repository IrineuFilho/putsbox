FROM ruby:2.5.5

ENV DEVISE_SECRET_KEY=6a9829027ca7bee2895a60b3e8c2b07d8c2569f071bdf431f738bd44b425764152f3a49b95a5b04f83e626124f84eb1ea411bfb42c227328cdb2c6ce950d063f
ENV SECRET_TOKEN=6a9829027ca7bee2895a60b3e8c2b07d8c2569f071bdf431f738bd44b425764152f3a49b95a5b04f83e626124f84eb1ea411bfb42c227328cdb2c6ce950d063f
ENV RAILS_ENV=production

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs --no-install-recommends

WORKDIR /app

## help docker cache bundle
ADD Gemfile                      /app/
ADD Gemfile.lock                 /app/
RUN bundle install

## Add & compile Webpack code in order from least likely to most likely to change to improve layer caching.
ADD vendor                              /app/vendor
ADD public                              /app/public
ADD config/locales                      /app/config/locales
ADD app/assets                          /app/app/assets

## Add APP code in order from least likely to most likely to change to improve layer caching.
ADD config.ru                           /app/config.ru
ADD Rakefile                            /app/Rakefile
ADD config                              /app/config
ADD lib                                 /app/lib
ADD bin                                 /app/bin
ADD app                                 /app/app

EXPOSE 8020

CMD ["bash"]
