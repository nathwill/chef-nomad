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
    agent['name'] = node['hostname']
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
      %w[
        0.7.1/nomad_0.7.1_darwin_amd64.zip
        3b9dda1ca2abec01ee3f239fe5b5f678b3937d998f06d9e2b3629ce4aa6cb895
      ]
    when 'windows'
      %w[
        0.7.1/nomad_0.7.1_windows_amd64.zip
        ebd429036ae7b8629c05a72a278afa5a2cf9d816092f1485c4dcf9bdc9f4d436
      ]
    else
      %w[
        0.7.1/nomad_0.7.1_linux_amd64.zip
        72b32799c2128ed9d2bb6cbf00c7600644a8d06c521a320e42d5493a5d8a789a
      ]
    end
end
