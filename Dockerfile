FROM alpine:3.4

LABEL maintainer Yahor Kastsialei<y.kastsialei@gmail.com>

RUN apk add --update nginx ca-certificates && mkdir -p /run/nginx && update-ca-certificates && apk add openssl && echo "docker:x:999:" > /etc/group
#   && chmod +x /opt/entrypoint.sh
ADD entrypoint.sh /opt/entrypoint.sh

ADD ./dist/* /usr/share/nginx/html/
ADD nginx.conf /etc/nginx/
EXPOSE 8080
ENTRYPOINT ["sh", "/opt/entrypoint.sh"]
