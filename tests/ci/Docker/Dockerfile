FROM tools-ext-01.ccr.xdmod.org/xdmod-base-9.0:centos7.8-0.1

ENV FED_BRANCH=xdmod9.5-update
ENV BRANCH=xdmod9.5-update
ENV REL=9.5.0
ENV BUILD=1.0
ENV FEDERATED_BUILD=0.1
ENV TERM=xterm-256color
ENV XDMOD_TEST_MODE=fresh_install

# We have some caches that we put in place for automated builds.
# This will copy them into place if they exist
COPY assets /tmp/assets
COPY scripts /tmp/scripts
COPY bootstrap-federation.sh /tmp/bootstrap/bootstrap-federation.sh
RUN /tmp/assets/copy-caches.sh
COPY bin /root/bin

#COPY /home/gmdean/xdmod /root/xdmod
RUN git clone https://github.com/eiffel777/xdmod/ --branch $BRANCH /root/xdmod
RUN git clone --single-branch --depth=1 https://github.com/eiffel777/xdmod-federated/ --branch $FED_BRANCH /root/xdmod/open_xdmod/modules/federated

WORKDIR /root/xdmod
RUN composer install

# Build the XDMoD RPM that will be installed in this docker image.
RUN /root/bin/buildrpm xdmod
RUN /root/bin/buildrpm federated

# Install / Upgrade based on the XDMOD_TEST_MODE env variable.
RUN /root/xdmod/tests/ci/bootstrap.sh

RUN /tmp/bootstrap/bootstrap-federation.sh

# Clean everything up
RUN yum clean all
RUN rm -rf /var/cache/yum /root/xdmod /root/rpmbuild

WORKDIR /
