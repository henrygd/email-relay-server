#! /bin/sh

bundle exec thin start -e production -a 0.0.0.0 &
supercronic /etc/crontabs/root
