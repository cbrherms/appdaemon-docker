FROM python:3.6

MAINTAINER mezz64 <jtmihalic@gmail.com>

LABEL org.freenas.autostart="true" \
      org.freenas.version="latest-beta" \
      org.freenas.expose-ports-at-host="true" \
      org.freenas.web-ui-protocol="http" \
      org.freenas.web-ui-port=5050 \
      org.freenas.web-ui-path="" \
      org.freenas.port-mappings="5050:5050/tcp" \
      org.freenas.volumes="[ \
          { \
              \"name\": \"/conf\", \
              \"descr\": \"HADashboard config\" \
          } \
      ]"

RUN apt-get update && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
VOLUME /conf

# Grab source
RUN git clone -b hadashboard_beta https://github.com/home-assistant/appdaemon.git .

# INSTALL
#RUN pip3 install daemonize configparser astral 'requests>=2.6.0' && \
#    pip3 install sseclient websocket-client async aiohttp==1.2.0 && \
#    pip3 install Jinja2==2.9.5 aiohttp_jinja2 pyScss pyyaml voluptuous


RUN pip3 install .

CMD [ "appdaemon", "-c", "/conf", "--commtype", "SSE" ]
