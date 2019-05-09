FROM debian:stretch as builder

## Supports x86_64, x86, arm, and arm64

ARG DEBIAN_FRONTEND=noninteractive
ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN apt-get update && apt-get install -y curl gnupg && \
    curl -s 'https://raw.githubusercontent.com/zerotier/download.zerotier.com/master/htdocs/contact%40zerotier.com.gpg' | gpg --import && \
    echo "deb http://download.zerotier.com/debian/stretch stretch main" > /etc/apt/sources.list.d/zerotier.list  && \
    apt-get update && apt-get install -y zerotier-one=1.2.12

# Set the base image
FROM lsiobase/alpine

# Dockerfile author / maintainer 
MAINTAINER Thomas <thomasvt@me.com>

RUN mkdir -p /var/lib/zerotier-one

COPY --from=builder /var/lib/zerotier-one/zerotier-cli /usr/sbin/zerotier-cli
COPY --from=builder /var/lib/zerotier-one/zerotier-idtool /usr/sbin/zerotier-idtool
COPY --from=builder /usr/sbin/zerotier-one /usr/sbin/zerotier-one

ADD start.sh /
RUN chmod 0755 /start.sh
ENTRYPOINT ["/start.sh"]
CMD ["zerotier-one"]
