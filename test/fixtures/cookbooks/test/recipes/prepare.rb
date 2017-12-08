
execute 'apt-get update' do
  only_if { platform_family?('debian') }
end

docker_service 'default' do
  action %i[create start]
end
