FROM alpine:latest
ARG directory='/temp_install'
# install dependencies
RUN apk add --update --no-cache ca-certificates perl perl-io-socket-ssl wget jq make curl && update-ca-certificates
# install application
RUN mkdir "${directory}"                        &&\
    cd "${directory}"                           &&\
    wget $(wget -q -O - https://api.github.com/repos/ddclient/ddclient/releases/latest  |  jq -r '.assets[] | select(.name | contains ("ddclient")) | .browser_download_url') &&\
    tar -xf *.tar.gz                            &&\
    cd *                                        &&\
    ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var &&\
    make                                        &&\
    make install
# cleanup
RUN apk del wget jq make && rm -R "${directory}"
# set cmd
WORKDIR /etc/ddclient
CMD /usr/bin/ddclient -daemon 300 -foreground -noquiet -debug
VOLUME /etc/ddclient/ddclient.conf
VOLUME /var/cache/ddclient/ddclient.cache
