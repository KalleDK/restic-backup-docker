FROM alpine:latest

RUN apk add --no-cache ca-certificates

# Get restic executable
ARG RESTIC_VERSION=0.9.0
RUN \
     wget -P /tmp https://github.com/restic/restic/releases/download/v${RESTIC_VERSION}/restic_${RESTIC_VERSION}_linux_amd64.bz2 \
  && bzip2 -d /tmp/restic_${RESTIC_VERSION}_linux_amd64.bz2 \
  && install -D -o root -g root -m 0755 /tmp/restic_${RESTIC_VERSION}_linux_amd64 /usr/local/bin/restic \
  && rm /tmp/restic_${RESTIC_VERSION}_linux_amd64
