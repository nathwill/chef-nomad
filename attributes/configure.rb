#
# Cookbook Name:: nomad
# Attributes:: configure
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

default['nomad'].tap do |nomad|
  nomad['data_dir'] = '/var/lib/nomad'

  nomad['atlas_join'] = false

  nomad['client_enabled'] = true
  nomad['server_enabled'] = false
end
default['nomad']['config'].tap do |config|
	config['server_list']=[] # Set for all clients, or set via consul
	config['server'] = false
	config['bootstrap_expect'] = 1
	config['bind_addr'] = '0.0.0.0'
	if node.has_key?('testkitchen') && node['testkitchen'].has_key?('ipaddress')
		config['advertise'] = { 
			'rpc' => "#{node.testkitchen.ipaddress}:4647",
			'serf' => "#{node.testkitchen.ipaddress}:4648"
		}
	else
		config['advertise'] = { 
			'rpc' => "#{node.ipaddress}:4647",
			'serf' => "#{node.ipaddress}:4648"
	}
	end
end

