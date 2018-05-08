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
        0.8.1/nomad_0.8.1_darwin_amd64.zip
        50e0d5c9c6a490cd5913b77bd4760092e549babc9185919664807d1678f8d438
      )
    when 'windows'
      %w(
        0.8.1/nomad_0.8.1_windows_amd64.zip
        1c5c26225228e6d4e972eecd27bcd6ea526126dd60bf915e71e32b09590556be
      )
    else
      %w(
        0.8.1/nomad_0.8.1_linux_amd64.zip
        2d44c77f980fca9ad0af77137b101bb6f0bfe828950c99876c3360b654758a04
      )
    end
end
