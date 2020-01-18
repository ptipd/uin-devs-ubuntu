#!/bin/sh
set -e
rm -f /run/apache2/apache2.pid
exec apache2ctl -DFOREGROUND
