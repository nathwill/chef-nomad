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
        0.8.0/nomad_0.8.0_darwin_amd64.zip
        5fbb606c3ed050c941cf09c2e65fa608a4ac7f549ac41bef54df67f8b7d65801
      )
    when 'windows'
      %w(
        0.8.0/nomad_0.8.0_windows_amd64.zip
        c3275d65d7f622ff2c089298f0872a1579ca02a58be654689fa83ba09945df82
      )
    else
      %w(
        0.8.0/nomad_0.8.0_linux_amd64.zip
        1166cc6cb8b8ef4af73c7ed745b938fd060c6a6222111c13ff5d88efbccd66c5
      )
    end
end
