FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y mysql-common nodejs yarnpkg
RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY package.json /app/package.json
COPY yarn.lock /app/yarn.lock
RUN ln -s /usr/bin/yarnpkg /usr/bin/yarn
RUN yarn install --ignore-engines

COPY . /app

RUN RAILS_ENV=production SECRET_KEY_BASE=lol rails assets:precompile

# Add a script to be executed every time the container starts.
COPY docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
