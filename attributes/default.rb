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
        0.11.3/nomad_0.11.3_darwin_amd64.zip
        5c4087d6e79e1465bd9464d17d196b489abfb0c3c1290fc56ab88843d92a08da
      )
    when 'windows'
      %w(
        0.11.3/nomad_0.11.3_windows_amd64.zip
        a211f492a08caa55267f703dda2685d97a6e41e462e70f0794a7f18e92f58d35
      )
    else
      %w(
        0.11.3/nomad_0.11.3_linux_amd64.zip
        f6a38099e27e8ff1dd7e1fe7215c954ebe4986d05ed6320739186ff3502bb78a
      )
    end
end
