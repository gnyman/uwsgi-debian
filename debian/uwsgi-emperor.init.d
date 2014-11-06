#!/bin/sh
# kFreeBSD do not accept scripts as interpreters, using #!/bin/sh and sourcing.
if [ true != "$INIT_D_SCRIPT_SOURCED" ]; then
	set "$0" "$@"
	INIT_D_SCRIPT_SOURCED=true . /lib/init/init-d-script
fi
### BEGIN INIT INFO
# Provides:          uwsgi-emperor
# Required-Start:    $local_fs $remote_fs $network
# Required-Stop:     $local_fs $remote_fs $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start/stop uWSGI server instance(s)
# Description:       This script manages uWSGI Emperor server instance(s).
### END INIT INFO

# Author: Jonas Smedegaard <dr@jones.dk>

DESC="uWSGI Emperor server"
DAEMON=/usr/bin/uwsgi
PIDFILE=/run/uwsgi-emperor.pid
LOGFILE=/var/log/uwsgi/emperor.log
DAEMON_ARGS="--ini /etc/uwsgi-emperor/emperor.ini --pidfile $PIDFILE --daemonize $LOGFILE"
SCRIPTNAME="/etc/init.d/uwsgi-emperor"

alias do_reload=do_reload_sigusr1
