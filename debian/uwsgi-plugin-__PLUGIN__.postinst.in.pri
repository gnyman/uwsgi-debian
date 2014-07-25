#!/bin/sh
# postinst script for @@pkg_name@@
#
# see: dh_installdeb(1)

set -e

# summary of how this script can be called:
#        * <postinst> `configure' <most-recently-configured-version>
#        * <old-postinst> `abort-upgrade' <new version>
#        * <conflictor's-postinst> `abort-remove' `in-favour' <package>
#          <new-version>
#        * <postinst> `abort-remove'
#        * <deconfigured's-postinst> `abort-deconfigure' `in-favour'
#          <failed-install-package> <version> `removing'
#          <conflicting-package> <version>
# for details, see http://www.debian.org/doc/debian-policy/ or
# the debian-policy package

case "$1" in
    configure)
      update-alternatives --quiet \
        --install \
          /usr/lib/uwsgi/plugins/@@plugin_alternatives_stem@@_plugin.so \
          @@plugin_alternatives_name@@ \
          /usr/lib/uwsgi/plugins/@@plugin_name@@_plugin.so \
          @@plugin_alternatives_priority@@ \
        --slave \
          /usr/bin/uwsgi_@@plugin_alternatives_stem@@ \
          uwsgi_@@plugin_alternatives_stem@@ \
          /usr/bin/uwsgi-core \
        --slave \
          /usr/share/man/man1/uwsgi_@@plugin_alternatives_stem@@.1.gz \
          uwsgi_@@plugin_alternatives_stem@@.1.gz \
          /usr/share/man/man1/uwsgi_@@plugin_name@@.1.gz

      update-alternatives --quiet \
        --install \
          /usr/bin/uwsgi \
          uwsgi \
          /usr/bin/uwsgi_@@plugin_name@@ \
          35 \
        --slave \
          /usr/share/man/man1/uwsgi.1.gz \
          uwsgi.1.gz \
          /usr/share/man/man1/uwsgi_@@plugin_name@@.1.gz

      BINARY_IS_UWSGI_ALTERNATIVE="$(\
        update-alternatives --list uwsgi 2>/dev/null \
        | grep '/uwsgi_@@plugin_alternatives_stem@@$' \
        | wc -l \
      )"
      if [ "$BINARY_IS_UWSGI_ALTERNATIVE" -eq 0 ]; then
        update-alternatives --quiet \
          --install \
            /usr/bin/uwsgi \
            uwsgi \
            /usr/bin/uwsgi_@@plugin_alternatives_stem@@ \
            35 \
          --slave \
            /usr/share/man/man1/uwsgi.1.gz \
            uwsgi.1.gz \
            /usr/share/man/man1/uwsgi_@@plugin_alternatives_stem@@.1.gz
      fi
    ;;

    abort-upgrade|abort-remove|abort-deconfigure)
    ;;

    *)
        echo "postinst called with unknown argument \`$1'" >&2
        exit 1
    ;;
esac

# dh_installdeb will replace this with shell code automatically
# generated by other debhelper scripts.

#DEBHELPER#

exit 0