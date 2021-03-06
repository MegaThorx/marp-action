FROM marpteam/marp-cli:latest

USER root
RUN apk update && apk upgrade && \
    apk add --no-cache git@edge bash@edge

WORKDIR /home/marp/app
COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]