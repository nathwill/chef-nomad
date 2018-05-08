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
        0.8.3/nomad_0.8.3_darwin_amd64.zip
        d7fdfaf95155f1c28adbd781a6c9afa528a7cb1b2387633fa986eed63f0a14f8
      )
    when 'windows'
      %w(
        0.8.3/nomad_0.8.3_windows_amd64.zip
        3a7861daf83289f49276847fcdafd1501adb3bf7b57e3b1ce40bc4b782e0dacf
      )
    else
      %w(
        0.8.3/nomad_0.8.3_linux_amd64.zip
        c7faaee8fad0f6a74df01b9283253ee565f85791adca1d6a38462e0387dee175
      )
    end
end
