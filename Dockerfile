FROM docker.io/alpine:latest

COPY entrypoint.sh /entrypoint.sh
RUN apk add --no-cache git jq && \
    wget https://github.com/git-chglog/git-chglog/releases/download/v0.15.4/git-chglog_0.15.4_linux_amd64.tar.gz && \
        tar xvf git-chglog_0.15.4_linux_amd64.tar.gz && \
        mv git-chglog /usr/local/bin/git-chglog && \
    chmod 755 /entrypoint.sh /usr/local/bin/git-chglog

ENTRYPOINT [ "/entrypoint.sh" ]
