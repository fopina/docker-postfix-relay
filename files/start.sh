#!/bin/sh

set -e

if [ -n "$1" ]; then
	exec "$@"
fi

[ -z "$SMTP_LOGIN" -o -z "$SMTP_PASSWORD" ] && {
	echo "SMTP_LOGIN and SMTP_PASSWORD _must_ be defined" >&2
	exit 1
}

export SMTP_LOGIN SMTP_PASSWORD
export SMTP_HOST=${SMTP_HOST:-"smtp.gmail.com"}
export SMTP_PORT=${SMTP_PORT:-"587"}
export ACCEPTED_NETWORKS=${ACCEPTED_NETWORKS:-"192.168.0.0/16 172.16.0.0/12 10.0.0.0/8"}
export TLS_VERIFY=${TLS_VERIFY:-"may"}

envsubst < /etc/postfix/main.cf.template > /etc/postfix/main.cf
newaliases

s6-svscan /etc/s6