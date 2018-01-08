ARG IMAGE

FROM ${IMAGE}

RUN set -x \
 && apk add --no-cache \
        ca-certificates \
        duplicity \
 && update-ca-certificates \
 && apk add --no-cache --virtual .build-deps \
        py-pip \
 && pip install fasteners \
 && apk del .build-deps

RUN mkdir /src

VOLUME ["/cache"]
VOLUME ["/src"]

WORKDIR /opt/duplicity

COPY bootstrap.sh /bootstrap.sh
COPY backup.sh /backup.sh

ENV HOME /opt/duplicity
ENV DUPLICITY_FLAGS ""
ENV CRON_SCHEDULE "0 */12 * * *"
ENV BACKUP_SRC "/src"

ENTRYPOINT ["/bootstrap.sh"]
