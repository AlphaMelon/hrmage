#!/usr/bin/env puma

threads 0, 16

bind "unix:///home/deployer/apps/hrmage/shared/sockets/puma.sock"
state_path '/home/deployer/apps/hrmage/shared/sockets/puma.state'

root = "/home/deployer/apps/hrmage/current"

pidfile "#{root}/tmp/pids/puma.pid"

stdout_redirect "#{root}/log/puma.log", "#{root}/log/puma-errors.log", true
activate_control_app 'unix:///home/deployer/apps/hrmage/shared/sockets/pumactl.sock'

workers 2
