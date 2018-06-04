FROM debian
ARG UID="107"
ENV USER='moby-unit-test'

RUN apt-get update && apt-get -y install ruby maven wget curl sudo openjdk-8-jdk

RUN useradd -s /bin/bash -m ${USER} -u ${UID} && echo "$USER:$USER" | chpasswd && adduser ${USER} sudo && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN gem install rubysl-ostruct \
    && gem install rubysl-optparse

ADD https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein /usr/bin/lein
RUN chmod a+rx /usr/bin/lein

USER ${USER}
WORKDIR /home/${USER}

# Checks
RUN lein --version
RUN mvn --version
RUN bash --version

RUN mkdir .m2/
COPY settings-template.xml .
COPY render-maven-settings render-maven-settings

# Build arg. If set to 'true', then no artifactory used.
ARG NO_ARTIFACTORY
# Build arg. If specified, image will be built with custom artifactory address for maven to use.
ARG ARTIFACTORY_ADDRESS

RUN ./render-maven-settings ".m2/settings.xml"
