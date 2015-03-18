FROM debian:jessie

ENV NODE_VERSION 0.10.35
ENV GIFSICLE_VERSION 1.87
ENV FFMPEG_VERSION 2.6
ENV WEBP_VERSION 0.4.3

WORKDIR /tmp

RUN apt-get update && apt-get install -y wget xz-utils gcc make

RUN echo WEBP && \
  wget -q "http://downloads.webmproject.org/releases/webp/libwebp-$WEBP_VERSION-linux-x86-32.tar.gz" && \
  tar -xf libwebp-$WEBP_VERSION-linux-x86-32.tar.gz && cd libwebp-$WEBP_VERSION-linux-x86-32/bin && \
  mv cwebp gif2webp /usr/local/bin/ &&\
  echo GIFSICLE && \
  wget -q "http://www.lcdf.org/gifsicle/gifsicle-$GIFSICLE_VERSION.tar.gz" && \
  tar -zxf "gifsicle-$GIFSICLE_VERSION.tar.gz" && cd gifsicle-$GIFSICLE_VERSION && \
  ./configure && make && make install && \
  echo NODE && \
  wget -q "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" && \
  tar -zxf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 && \
  echo FFMPEG && \
  wget -q "http://johnvansickle.com/ffmpeg/releases/ffmpeg-$FFMPEG_VERSION-64bit-static.tar.xz" && \
  tar -xf ffmpeg-$FFMPEG_VERSION-64bit-static.tar.xz && cd ffmpeg-$FFMPEG_VERSION-64bit-static && \
  mv ffmpeg ffmpeg-10bit ffprobe qt-faststart /usr/local/bin/ && \
  echo PHANTOMJS && \
  wget -q https://github.com/Pyppe/phantomjs2.0-ubuntu14.04x64/raw/master/bin/phantomjs && mv phantomjs /usr/bin && chmod +x /usr/bin/phantomjs && \
  npm install -g npm && npm cache clear && apt-get clean && rm -rf /tmp/*

CMD ["/bin/bash"]
