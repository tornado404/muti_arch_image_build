FROM alpine:3.14
RUN apk add fuse fuse-dev bash
RUN  apk --update add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/shanghai" > /etc/timezone \
    && apk del tzdata