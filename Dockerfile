# Set the base image
FROM lsiobase/alpine

# Dockerfile author / maintainer 
MAINTAINER Thomas <thomasvt@me.com>

RUN curl -s https://install.zerotier.com/ | sudo bash

ADD start.sh /
RUN chmod 0755 /start.sh
ENTRYPOINT ["/start.sh"]
CMD ["zerotier-one"]
