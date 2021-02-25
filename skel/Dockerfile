FROM ubuntu:18.04
MAINTAINER Niklas Thorne "notrupertthorne@gmail.com"

# USAGE:
#
# building the image:
#   TODO
#
# running the container:
#   TODO

# Take these as ARG so that we can use same UID:GID in container,
# and avoid messed up permissions on files and folders.
ARG UID=1000
ARG GID=100

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG IMAGE=TODO
ARG VERSION=latest
ARG VCS_REF
ARG VCS_URL
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name=$IMAGE \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.schema-version="1.0"

RUN apt-get update && apt-get install -y \
  hello


# Use s6 for process supervision
RUN wget https://github.com/just-containers/s6-overlay/releases/download/v2.0.0.1/s6-overlay-amd64.tar.gz -P /tmp \
    && gunzip -c /tmp/s6-overlay-amd64.tar.gz | tar -xf - -C /


# Create bob the builder user, set the home directory to
# /config in order to avoid e.g. bash creating dotfiles
# in the source tree.
RUN groupadd -g $GID users ; \
  useradd -u $UID -g $GID -d /config -s /bin/false bob

ENV HOME=/config
WORKDIR /home/bob

ENTRYPOINT [ "/init", "s6-setuidgid", "bob" ]
# TODO: Add whatever we want to execute as a command to bash
CMD ["/bin/bash"]
