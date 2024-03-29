FROM ubuntu:jammy
ARG UID="114"
ENV USER='moby-unit-test'

RUN apt-get update && apt-get -y install ruby maven wget curl sudo openjdk-17-jdk git

RUN useradd -s /bin/bash -m ${USER} -u ${UID} && echo "$USER:$USER" | chpasswd && adduser ${USER} sudo && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN gem install rubysl-ostruct \
    && gem install optparse

ADD https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein /usr/bin/lein
RUN chmod a+rx /usr/bin/lein

USER ${USER}
WORKDIR /home/${USER}

# java jdk 8 verzio beallitasa
RUN sudo rm /etc/alternatives/java
RUN sudo ln -s /usr/lib/jvm/java-1.17.0-openjdk-amd64/bin/java /etc/alternatives/java

# Checks
RUN java -version
RUN lein --version
RUN mvn --version
RUN bash --version
RUN git --version

RUN mkdir .m2/
COPY settings-template.xml .
COPY render-maven-settings render-maven-settings

# Build arg. If set to 'true', then no artifactory used.
ARG NO_ARTIFACTORY
# Build arg. If specified, image will be built with custom artifactory address for maven to use.
ARG ARTIFACTORY_ADDRESS

RUN ./render-maven-settings ".m2/settings.xml"
