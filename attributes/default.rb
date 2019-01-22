#
# Cookbook Name:: nomad
# Attributes:: default
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

default['nomad'].tap do |nomad|
  nomad['agent'].tap do |agent|
    agent['bind_addr'] = '0.0.0.0'
    agent['data_dir'] = '/var/lib/nomad'
    agent['client_enabled'] = true
    agent['server_enabled'] = false
  end

  nomad['daemon_args'].tap do |args|
    args['config'] = NomadCookbook::Helpers::CONFIG_ROOT
  end
  nomad['source_url'] = 'https://releases.hashicorp.com/nomad'

  nomad['package'], nomad['checksum'] =
    case node['os']
    when 'mac_os_x'
      %w(
        0.8.7/nomad_0.8.7_darwin_amd64.zip
        70e21f908afde83b57e25602939210541222133ccbfabdab68a548df5f3226f2
      )
    when 'windows'
      %w(
        0.8.7/nomad_0.8.7_windows_amd64.zip
        e6c790f7210e41ccf5a0ce9cc4892daa26a83fcb56dce960d8739e7a2a69aac1
      )
    else
      %w(
        0.8.7/nomad_0.8.7_linux_amd64.zip
        a5a3a507ee8048ab2337427824b5e7fd0c6c069ca5d2f545f13f742af0a707da
      )
    end
end
