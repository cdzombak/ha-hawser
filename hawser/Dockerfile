ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG HAWSER_VERSION
ARG BUILD_ARCH

# Map HA arch names to hawser release arch names
RUN set -eux; \
    case "${BUILD_ARCH}" in \
        amd64)   HAWSER_ARCH="amd64" ;; \
        aarch64) HAWSER_ARCH="arm64" ;; \
        armv7)   HAWSER_ARCH="arm" ;; \
        *)       echo "Unsupported arch: ${BUILD_ARCH}"; exit 1 ;; \
    esac; \
    TARBALL="hawser_${HAWSER_VERSION}_linux_${HAWSER_ARCH}.tar.gz"; \
    wget -q -O /tmp/hawser.tar.gz \
        "https://github.com/Finsys/hawser/releases/download/v${HAWSER_VERSION}/${TARBALL}"; \
    tar -xzf /tmp/hawser.tar.gz -C /usr/bin hawser; \
    chmod +x /usr/bin/hawser; \
    rm -f /tmp/hawser.tar.gz

COPY run.sh /
RUN chmod +x /run.sh

CMD ["/run.sh"]
