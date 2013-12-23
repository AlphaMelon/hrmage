set :stage, :production

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
role :app, %w{deployer@himeragi.collectskin.com}
role :web, %w{deployer@himeragi.collectskin.com}
role :db,  %w{deployer@himeragi.collectskin.com}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server 'himeragi.collectskin.com', user: 'deploy', roles: %w{web app}, my_property: :my_value

set :branch, 'master'
set :ssh_options, forward_agent: true


