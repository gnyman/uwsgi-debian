import os

NAME='php'

ld_run_path = None
PHPPATH = 'php-config'

phpdir = os.environ.get('UWSGICONFIG_PHPDIR')
if phpdir:
    ld_run_path = "%s/lib" % phpdir
    PHPPATH = "%s/bin/php-config" % phpdir

PHPPATH = os.environ.get('UWSGICONFIG_PHPPATH', PHPPATH)

CFLAGS = [os.popen(PHPPATH + ' --includes').read().rstrip(), '-Wno-sign-compare']
LDFLAGS = os.popen(PHPPATH + ' --ldflags').read().rstrip().split()
LDFLAGS.append('-L/usr/lib/php5')

if ld_run_path:
    LDFLAGS.append('-L%s' % ld_run_path)
    os.environ['LD_RUN_PATH'] = ld_run_path

LIBS = ['-lphp5']

phplibdir = os.environ.get('UWSGICONFIG_PHPLIBDIR')
if phplibdir:
    LIBS.append('-Wl,-rpath=%s' % phplibdir)

GCC_LIST = ['php_plugin']
