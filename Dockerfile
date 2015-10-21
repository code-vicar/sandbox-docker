FROM java:8

MAINTAINER Scott Vickers <scott.w.vickers@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

ENV GOSU_DOWNLOAD_SHA256 6f9a6f5d75e25ba3b5ec690a5c601140c43929c3fe565cea2687cc284a8aacc8

# Add sandbox user account
RUN mkdir -p /usr/local/sandbox \
&& useradd -d /usr/local/sandbox sandbox

# Install gosu 1.5
RUN apt-get -y update \
&& apt-get install --quiet --assume-yes --no-install-recommends \
ca-certificates \
wget

RUN cd /usr/local/sandbox \
&& wget -nv --ca-directory=/etc/ssl/certs "https://s3-us-west-2.amazonaws.com/getsandbox-assets/runtime-binary.tar"

RUN cd /usr/local/sandbox \
&& tar xf runtime-binary.tar \
&& ls -la sandbox \
&& rm -rf runtime-binary.tar

RUN cd / \
&& wget -O gosu -nv --ca-directory=/etc/ssl/certs "https://github.com/tianon/gosu/releases/download/1.5/gosu-amd64" \
&& echo "$GOSU_DOWNLOAD_SHA256 *gosu" | sha256sum -c - \
&& chmod +x gosu

RUN apt-get purge -y --auto-remove \
wget \
&& apt-get clean

COPY ./main.js /main.js

RUN chown -R sandbox:sandbox /usr/local/sandbox

ENV PATH /usr/local/sandbox:$PATH

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8080 10000 9000 8005

CMD ["sandbox"]
