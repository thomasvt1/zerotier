FROM debian:stretch as builder

## Supports x86_64, x86, arm, and arm64

ENV DEBIAN_FRONTEND=noninteractive
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN apt-get update && apt-get install -y curl gnupg && \
    curl -s 'https://pgp.mit.edu/pks/lookup?op=get&search=0x1657198823E52A61' | gpg --import && if z=$(curl -s 'https://install.zerotier.com/' | gpg); then echo "$z" | sudo bash; fi

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
