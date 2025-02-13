FROM alpine:latest
RUN apk add --update --no-cache tini perl ca-certificates wget perl-io-socket-ssl && update-ca-certificates
# use https://github.com/krallin/tini init to handle command signals properly
ENTRYPOINT ["/sbin/tini", "--"]
# run install.sh to install ddclient
COPY install.sh /tmp/
RUN /tmp/install-ddclient.sh
# set cmd for ddclient
CMD ["/usr/bin/ddclient", "-daemon", "300", "-foreground", "-noquiet", "-debug"]
# define volume
VOLUME ["/etc/ddclient"]
