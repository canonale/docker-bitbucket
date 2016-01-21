FROM alpine

ENV BRANCH master

ADD entrypoint.sh /entrypoint.sh
run apk --update add openssh-client git \
    && mkdir /root/.ssh \
    && chmod 777 /entrypoint.sh

VOLUME /app
ENTRYPOINT /entrypoint.sh

CMD ["/bin/ash", "/entrypoint.sh"]
