# Postfix Relay

Simple (maybe unstable) SMTP relay to use with other containers so you only need to configure postfix once (instead of every container that needs to send mail)

This is basically a copy from [shamil/docker-postfix-relay](https://github.com/shamil/docker-postfix-relay)


### Exposed ports

Postfix on port `25`

### Environment variables

* `ACCEPTED_NETWORKS` (default: `192.168.0.0/16 172.16.0.0/12 10.0.0.0/8`)
* `SMTP_HOST` (default: `smtp.gmail.com`)
* `SMTP_PORT` (default: `587`)
* `SMTP_LOGIN` **required**
* `SMTP_PASSWORD` **required** or use `SMTP_PASSWORD_FILE` point to a file with the password (useful with docker secrets and others)
* `TLS_VERIFY` (default: `may`) options: none, may, encrypt, dane, dane-only, fingerprint, verify, secure

Container `HOSTNAME` variable is used as relay hostname (`myhostname = ${HOSTNAME}` in postfix configuration).

### Usage

Launch Postfix container:

    docker run -d -e SMTP_LOGIN=a@gmail.com -e SMTP_PASSWORD=xx -p 25:25 fopina/postfix-relay

Or using the password file variable:

	docker run -d -v /docker/secrets:/secrets:ro -e SMTP_LOGIN=a@gmail.com -e SMTP_PASSWORD_FILE=/secrets/smtp_pwd.txt -p 25:25 fopina/postfix-relay


Using it with other containers, no need to publish port:

	docker run -d --name=mailrelay -e SMTP_LOGIN=a@gmail.com -e SMTP_PASSWORD=xx fopina/postfix-relay

And then just link the other container (this is testing one that you can use to verify all is good):

	docker run --rm --link mailrelay:mailrelay fopina/postfix-relay:tester from@mail.com test@mail.com
