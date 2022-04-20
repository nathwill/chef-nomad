#
# Cookbook:: nomad
# Attributes:: default
#
# Copyright:: 2015-2018, Nathan Williams <nath.e.will@gmail.com>
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
    agent['acl_enabled'] = false
  end

  nomad['daemon_args'].tap do |args|
    args['config'] = NomadCookbook::Helpers::CONFIG_ROOT
  end
  nomad['source_url'] = 'https://releases.hashicorp.com/nomad'

  nomad['package'], nomad['checksum'] =
    case node['os']
    when 'mac_os_x'
      %w(
        1.2.6/nomad_1.2.6_darwin_amd64.zip
        34d09fbfa9829fbe8660fc721d82fd867f8aa462c277f1a6f1046c731c81af23
      )
    when 'windows'
      %w(
        1.2.6/nomad_1.2.6_windows_amd64.zip
        c0eed52f7647e36c4a662bb76789962b2280821a08890410da7956b1c66b2891
      )
    else
      %w(
        1.2.6/nomad_1.2.6_linux_amd64.zip
        a7bee57db3c3a595ecba964f7afee9c32ebb6799eb7a1682deb0a7cd8e7d08c0
      )
    end
end
