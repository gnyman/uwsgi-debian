import uwsgi

uwsgi.load_plugin(0, "psgi_plugin.so", "test.psgi")
