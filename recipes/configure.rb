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

Chef::Log.info("Configuring #{cookbook_name}")

nomad = node['nomad']

directory Nomad::Helpers::CONFIG_ROOT

nomad_config '00-agent' do
  data_dir nomad['data_dir']
end

nomad_server_config '00-server' do
  enabled nomad['server_enabled']
  bootstrap_expect nomad['bootstrap_expect']
end

nomad_client_config '00-client' do
  enabled nomad['client_enabled']
end

nomad_atlas_config '00-atlas' do
  join nomad['atlas_join']
end
