# debian:jessie -> buildpack-deps:jessie-curl -> buildpack-deps:jessie-scm -> java:8
FROM java:8

MAINTAINER Scott Vickers <scott.w.vickers@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

ENV SANDBOX_DOWNLOAD_SHA256 f02c9f20e6d5681afcdcc33fc8fddd2f696b2059a955b2aa6ef989a5d15549eb
ENV GOSU_DOWNLOAD_SHA256 6f9a6f5d75e25ba3b5ec690a5c601140c43929c3fe565cea2687cc284a8aacc8

# Add sandbox user account
RUN mkdir -p /usr/local/sandbox \
&& useradd -d /usr/local/sandbox sandbox

# Install sandbox pre-built binary
# Install gosu 1.5
RUN cd /usr/local/sandbox \
&& wget -nv --ca-directory=/etc/ssl/certs "https://s3-us-west-2.amazonaws.com/getsandbox-assets/runtime-binary.tar" \
&& echo "$SANDBOX_DOWNLOAD_SHA256 runtime-binary.tar" | sha256sum -c - \
&& tar xf runtime-binary.tar \
&& rm -rf runtime-binary.tar \
&& cd / \
&& wget -O gosu -nv --ca-directory=/etc/ssl/certs "https://github.com/tianon/gosu/releases/download/1.5/gosu-amd64" \
&& echo "$GOSU_DOWNLOAD_SHA256 *gosu" | sha256sum -c - \
&& chmod +x gosu

RUN chown -R sandbox:sandbox /usr/local/sandbox

WORKDIR /usr/local/sandbox

COPY entrypoint.sh entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 8080 10000 9000 8005

CMD ["./sandbox", "run"]
