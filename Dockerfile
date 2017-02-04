from ruby:alpine
ADD Gemfile /
RUN bundle install
ADD . /
ENTRYPOINT ["ruby", "entrypoint.rb"]
