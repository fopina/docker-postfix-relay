#!/usr/bin/env python

import smtplib

def main(from_address, to_address):
	msg = "\r\n".join([
	  "From: %s" % from_address,
	  "To: %s" % to_address,
	  "Subject: Hello",
	  "",
	  "Bye!"
	  ])
	server = smtplib.SMTP('localhost:2525')
	server.sendmail(from_address, to_address, msg)
	server.quit()

if __name__ == '__main__':
	import sys
	main(*sys.argv[1:])