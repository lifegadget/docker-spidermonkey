FROM debian:wheezy
MAINTAINER LifeGadget <contact-us@lifegadget.co>
 
# Basic environment setup
# note: SpiderMonkey build req's: https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/Linux_Prerequisites
ENV DEBIAN_FRONTEND noninteractive
# SpiderMonkey dependencies
RUN apt-get update \
	&& export MOZ_JS_VERSON=24.2.0 \
	&& apt-get install -y unzip gcc g++ make patch zip mercurial libasound2-dev libcurl4-openssl-dev libnotify-dev libxt-dev libiw-dev libidl-dev   \
	&& apt-get install -y mesa-common-dev autoconf2.13 yasm libgtk2.0-dev libdbus-1-dev libdbus-glib-1-dev python-dev  \
	&& apt-get install -y libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libpulse-dev wget
# Download and Configure SpiderMonkey
RUN mkdir -p /tmp/spidermonkey \
	&& cd /tmp/spidermonkey \
	&& wget -O/tmp/spidermonkey/mozjs-24.2.0.tar.bz2 http://ftp.mozilla.org/pub/mozilla.org/js/mozjs-24.2.0.tar.bz2 
RUN cd /tmp/spidermonkey \
	&& tar xjf mozjs-24.2.0.tar.bz2 \
	&& cd /tmp/spidermonkey/mozjs-24.2.0/js/src \
	&& autoconf2.13 \
	&& mkdir build-release \
	&& cd build-release \
	&& ../configure 
# Make and Install SpiderMonkey (and add jsawk and resty too)
RUN make make \
	&& make install \
	&& wget -O/usr/local/bin/jsawk http://github.com/micha/jsawk/raw/master/jsawk \
	&& wget -O/usr/local/bin/resty http://github.com/micha/resty/raw/master/resty \
	&& { \
		echo ""; \
		echo "source /usr/local/bin/resty"; \
		echo ""; \
	} >> /etc/bash.bashrc