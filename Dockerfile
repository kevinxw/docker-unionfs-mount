FROM alpine

ENV TZ="America/Edmonton"
ENV PUID=1000
ENV PGID=1000

RUN \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
   ca-certificates \
   tzdata \
   unionfs-fuse && \
 echo "**** configure fuse ****" && \
 sed -ri 's/^#user_allow_other/user_allow_other/' /etc/fuse.conf && \
 echo "**** cleanup ****" && \
 rm -rf \
        /tmp/*

ADD start.sh /start.sh

VOLUME ["/read-only"]
VOLUME ["/read-write"]
VOLUME ["/unionfs"]

CMD ["/start.sh"]
