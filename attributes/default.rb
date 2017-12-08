#
# Cookbook Name:: nomad
# Attributes:: default
#
# Copyright 2015-2016, Nathan Williams <nath.e.will@gmail.com>
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

  nomad['data_dir'] = '/var/lib/nomad'

  nomad['atlas_join'] = false

  nomad['client_enabled'] = true
  nomad['server_enabled'] = false

  nomad['source_url'] = 'https://releases.hashicorp.com/nomad'
  nomad['package'], nomad['checksum'] =
    case node['os']
    when 'mac_os_x'
      %w[
        0.5.6/nomad_0.5.6_darwin_amd64.zip
        235ddfd4c18c9875ae78607f9611a84ddf425a184fcb2359c734e7d117379ab3
      ]
    when 'windows'
      %w[
        0.5.6/nomad_0.5.6_windows_amd64.zip
        fc8c735ebfd6d14c439d52d64ada4af678d2685ef54cc8b819d714477675e2db
      ]
    else
      %w[
        0.5.6/nomad_0.5.6_linux_amd64.zip
        3f5210f0bcddf04e2cc04b14a866df1614b71028863fe17bcdc8585488f8cb0c
      ]
    end

  nomad['daemon_args'].tap do |args|
    args['config'] = Nomad::Helpers::CONFIG_ROOT
  end
end
