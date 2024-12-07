FROM alpine:3.21

RUN apk --no-cache add ca-certificates postfix gettext rsyslog s6

ADD files/ /

EXPOSE 25

ENTRYPOINT ["/start.sh"]
