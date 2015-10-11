require 'serverspec'

set :backend, :exec

sleep 10 # let the allocation spin up the service
