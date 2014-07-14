#             NB: ENV DEBIAN_FRONTEND noninteractive just hides some warnings. Setting it globally here is a bad idea.
FROM          ubuntu:14.04

#             https://github.com/chriswessels
MAINTAINER    Chris Wessels <undefined.za@gmail.com>

#             Ensure Ubuntu is up-to-date
RUN           sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
              apt-get update && \
              apt-get -y upgrade && \
              locale-gen en_US.UTF-8

#             Install build and packaging essentials, as well as basic utils
RUN           apt-get install -y build-essential software-properties-common python-software-properties curl git unzip wget

#             Set language environment variables system-wide
ENV           LANG en_US.UTF-8
ENV           LANGUAGE en_US.UTF-8
ENV           LC_ALL en_US.UTF-8
ENV           HOME /root

#             Install supervisor and create log and config directories
RUN           apt-get -y install supervisor &&
              mkdir -p /var/log/supervisor && \
              mkdir -p /etc/supervisor/conf.d

#             Add supervisor base configuration to image
ADD           supervisor.conf /etc/supervisor.conf

#             Set default container process to supervisord
CMD           ["supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
