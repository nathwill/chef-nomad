
execute 'apt-get update' do
  only_if { platform_family?('debian') }
end

package 'docker' do
  package_name value_for_platform_family(
    'debian' => 'docker.io',
    'default' => 'docker'
  )
end

service 'docker' do
  service_name value_for_platform_family(
    'debian' => 'docker.io',
    'default' => 'docker'
  )
  action [:enable, :start]
end
