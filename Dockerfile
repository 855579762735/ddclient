FROM alpine:latest
RUN \
	apk add --update --no-cache \
		tini \
		perl \
		ca-certificates \
		wget \
		perl-io-socket-ssl \
	&& \
	update-ca-certificates

# Use tini 'init' system to handle signals properly:
# https://github.com/krallin/tini
ENTRYPOINT ["/sbin/tini", "--"]

# Install ddclient using simple script:
COPY install-ddclient.sh /tmp/
RUN /tmp/install-ddclient.sh

# Set cmd for ddclient:
CMD ["/usr/bin/ddclient", "-daemon", "300", "-foreground", "-noquiet", "-debug"]

# Config volume
VOLUME ["/etc/ddclient"]
