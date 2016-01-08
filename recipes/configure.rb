#
# Cookbook Name:: nomad
# Recipe:: configure
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

nomad = node['nomad']
config = nomad['config']

nomad_config '00-default' do
  data_dir nomad['data_dir']
  bind_addr config['bind_addr']
  advertise config['advertise']
end

if nomad['server_enabled']
	nomad_server_config '00-default' do
	  enabled nomad['server_enabled']
	  bootstrap_expect config['bootstrap_expect']
	end
end

nomad_client_config '00-default' do
  enabled nomad['client_enabled']
  servers config['server_list']
end

nomad_atlas_config '00-default' do
  join nomad['atlas_join']
end

template "/etc/profile.d/nomad.sh" do
  source "nomad.sh.erb"
  mode '0755'
  owner 'root'
  group 'root'
  if nomad['server_enabled']
    variables ({
      :server_ip => "#{config['bind_addr']}:4646"
      })
  elsif ! config['server_list'].empty?
    variables ({
      :server_ip => config['server_list'].first.split(':')[0] + ":4646"
      })
  else
    variables({ :server_ip => '127.0.0.1:4646' })
  end
end
