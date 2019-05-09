FROM zerotier/zerotier-containerized:latest

COPY start.sh /start.sh
RUN chmod +x start.sh
