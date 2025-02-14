FROM alpine:latest
ARG directory='/temp/ddclient'
RUN apk add --update --no-cache ca-certificates perl perl-io-socket-ssl tini wget jq make && update-ca-certificates
# use https://github.com/krallin/tini init to handle command signals properly
ENTRYPOINT ["/sbin/tini", "--"]
# install application
RUN mkdir ${directory}       &&\
    cd ${directory}          &&\
    wget $(wget -q -O - https://api.github.com/repos/ddclient/ddclient/releases/latest  |  jq -r '.assets[] | select(.name | contains ("ddclient")) | .browser_download_url') &&\
    tar -xf *.tar.gz         &&\
    cd *                     &&\
    ./configure --prefix=${directory}/user --sysconfdir=${directory}/etc --localstatedir=${directory}/var &&\
    make                     &&\
    make VERBOSE=1 check     &&\
    make install             &&\
    cd ${directory}          &&\
    rm *.tar.gz
# cleanup
RUN apk del wget jq make
# set cmd
CMD [${directory}, "-daemon", "300", "-foreground", "-noquiet", "-debug"]
# set volumes
VOLUME [${directory}]
# run install.sh to install ddclient - no longer needed
#COPY install.sh /tmp/
#RUN /tmp/install-ddclient.sh
