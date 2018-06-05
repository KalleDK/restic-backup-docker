FROM alpine:latest

RUN apk add --no-cache ca-certificates

ARG ARCH=amd64

# Install restic
ARG RESTIC_VERSION=0.9.0
RUN \
     wget -P /tmp https://github.com/restic/restic/releases/download/v${RESTIC_VERSION}/restic_${RESTIC_VERSION}_linux_${ARCH}.bz2 \
  && bzip2 -d /tmp/restic_${RESTIC_VERSION}_linux_${ARCH}.bz2 \
  && install -D -o root -g root -m 0755 /tmp/restic_${RESTIC_VERSION}_linux_${ARCH} /usr/local/bin/restic \
  && rm /tmp/restic_${RESTIC_VERSION}_linux_${ARCH}

# Install rclone
ARG RCLONE_VERSION=1.41
RUN \
      wget -P /tmp https://github.com/ncw/rclone/releases/download/v${RCLONE_VERSION}/rclone-v${RCLONE_VERSION}-linux-${ARCH}.zip \
   && unzip /tmp/rclone-v${RCLONE_VERSION}-linux-${ARCH}.zip -d /tmp \
   && install -D -o root -g root -m 0755 /tmp/rclone-v${RCLONE_VERSION}-linux-${ARCH}/rclone /usr/local/bin/rclone \
   && rm -r /tmp/rclone-v${RCLONE_VERSION}-linux-${ARCH} /tmp/rclone-v${RCLONE_VERSION}-linux-${ARCH}.zip

ENV XDG_CONFIG_HOME=/usr/local/etc
ENV XDG_CACHE_HOME=/var/cache

VOLUME ["/usr/local/etc/rclone", "/usr/local/etc/restic", "/var/cache/restic"]
