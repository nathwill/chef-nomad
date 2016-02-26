#
# Cookbook Name:: nomad
# Recipe:: default
#
# Copyright 2015 The Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

args = Nomad::Helpers.hash_to_arg_string(node['nomad']['daemon_args'])

systemd_service 'nomad' do
  description 'Nomad System Scheduler'
  documentation 'https://nomadproject.io/docs/index.html'
  install do
    wanted_by %w( multi-user.target )
  end
  service do
    exec_start "/usr/local/bin/nomad agent #{args}"
    restart 'on-failure'
  end
  action :create
  only_if { IO.read('/proc/1/comm').chomp == 'systemd' }
end

template '/etc/init/nomad.conf' do
  source 'upstart.conf.erb'
  variables(
    daemon_args: args,
    server: node['nomad']['config']['server']
  )
  action :create
  only_if { ::File.executable?('/sbin/initctl') }
end

service 'nomad' do
  if ::File.executable?('/sbin/initctl')
    provider Chef::Provider::Service::Upstart
  end
  action [:enable, :start]
end
