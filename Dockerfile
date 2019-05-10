FROM thomasvt1/zerotier-containerized:latest

COPY main.sh /main.sh
RUN chmod +x main.sh
