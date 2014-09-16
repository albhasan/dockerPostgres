#!/bin/bash
export LC_ALL="en_US.UTF-8"
/etc/init.d/postgresql start
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'xxxx.xxxx.xxxx';"

