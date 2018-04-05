FROM maven:3.5.3-jdk-8-alpine

USER root
WORKDIR /root

RUN apk update \
    && apk add ruby ruby-dev ruby-json ruby-rdoc ruby-irb

RUN gem install rubysl-ostruct \
    && gem install rubysl-optparse

ADD https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein /usr/bin/lein
RUN chmod u+x /usr/bin/lein

# Checks
RUN lein --version
RUN mvn --version
RUN bash --version
