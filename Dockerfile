FROM ahdinosaur/debian-ruby
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev imagemagick libmagickwand-dev
RUN mkdir /loomio
WORKDIR /loomio
ADD Gemfile /loomio/Gemfile
RUN /bin/bash -l -c "bundle install"
ADD . /loomio
RUN /bin/bash -l -c "bundle exec rake db:create"
RUN /bin/bash -l -c "bundle exec rake db:schema:load"
RUN /bin/bash -l -c "bundle exec rake db:seed"
