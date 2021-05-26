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
        1.1.0/nomad_1.1.0_darwin_amd64.zip
        54c4f847c323661f3194134137e1d37889546d21d7308f70bf0c894a0fa236f
      )
    when 'windows'
      %w(
        1.1.0/nomad_1.1.0_windows_amd64.zip
        c15f60c31be97025d7bbbba1ef953bacca2b32fb50a63532f0537d842adb336b
      )
    else
      %w(
        1.1.0/nomad_1.1.0_linux_amd64.zip
        7c3b35520fc05e4aad49663564a852448f52ad58e3261040c9df2f6a44716736
      )
    end
end
