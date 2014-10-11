#!/bin/sh

portsnap fetch update
less /usr/ports/UPDATING
portmaster -Da
 
freebsd-update fetch
freebsd-update install