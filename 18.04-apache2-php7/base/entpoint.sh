#!/bin/sh
set -e
rm -f /run/apache2/apache2.pid
[ -x /cfg ] && /cfg
exec apache2ctl -DFOREGROUND
