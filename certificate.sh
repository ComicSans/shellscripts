#!/bin/sh

openssl req -nodes -x509 -newkey rsa:4096 -keyout key.pem -out cert.crt -days 356 -subj "/C=US/ST=Oregon/L=Portland/O=IT/CN=www.example.com"