FROM ahdinosaur/debian-ruby

RUN echo "deb http://http.debian.net/debian wheezy-backports main" >> /etc/apt/sources.list.d/backports.list

RUN apt-get update -qq
RUN apt-get install -y nodejs
RUN apt-get install -y build-essential git libpq-dev postgresql-contrib imagemagick libmagickwand-dev

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install --deployment --full-index --jobs $(nproc)

ADD . /opt/loomio
WORKDIR /opt/loomio

CMD bundle exec foreman start
