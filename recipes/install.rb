#
# Cookbook Name:: nomad
# Recipe:: install
#
# Copyright 2015-2018, Nathan Williams <nath.e.will@gmail.com>
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

include_recipe 'ark'

ark 'nomad' do
  url ::File.join(node['nomad']['source_url'], node['nomad']['package'])
  checksum node['nomad']['checksum']
  version node['nomad']['package'].match(/\d+\.\d+\.\d+/).to_s
  strip_components 0
  prefix_bin '/usr/local/sbin'
  has_binaries %w(nomad)
  action :install
end
