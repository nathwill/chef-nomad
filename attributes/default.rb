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
        0.8.5/nomad_0.8.5_darwin_amd64.zip
        b213aca736d6aff3cb897a325e39240172b4c2f117be5be4805deb838e25ab1d
      )
      when 'windows'
        %w(
        0.8.5/nomad_0.8.5_windows_amd64.zip
        c30ce30311be1cedfe3bc3b76d22b2273d115a9fb64d7bf88faccfa949c9e6e7
      )
      else
        %w(
        0.8.5/nomad_0.8.5_linux_amd64.zip
        e56c0e95e7a724b4fadd8eba32da5a3f2846f67e22e2352b19d1ada2066e063b
      )
      end
end
