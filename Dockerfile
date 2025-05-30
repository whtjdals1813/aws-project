FROM jenkins/jenkins:latest
ARG DOCKER_GID=1000
USER root

COPY scripts/command-line command-line

# aws cli install
COPY scripts/install-awscli.sh install-awscli.sh
RUN chmod u+x install-awscli.sh && ./install-awscli.sh

# docker install
COPY scripts/install-docker.sh install-docker.sh
RUN chmod u+x install-docker.sh && ./install-docker.sh

# zip install
RUN apt install zip unzip -y

# set jenkins user to host docker group
RUN /usr/sbin/groupadd -g ${DOCKER_GID:-1000} -f docker && /usr/sbin/usermod -aG docker jenkins

USER jenkins
