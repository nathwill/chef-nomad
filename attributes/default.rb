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
        0.7.0/nomad_0.7.0_darwin_amd64.zip
        53452f5bb27131f1fe5a5f9178324511bcbc54e4fef5bec4e25b049ac38e0632
      ]
    when 'windows'
      %w[
        0.7.0/nomad_0.7.0_windows_amd64.zip
        b049e70f1d4bc1e8102c988dbd2816bada781b5823b449eaeee40049df71309e
      ]
    else
      %w[
        0.7.0/nomad_0.7.0_linux_amd64.zip
        b3b78dccbdbd54ddc7a5ffdad29bce2d745cac93ea9e45f94e078f57b756f511
      ]
    end

  nomad['daemon_args'].tap do |args|
    args['config'] = Nomad::Helpers::CONFIG_ROOT
  end
end
