#
# Cookbook Name:: nomad
# Attributes:: default
#
# Copyright 2015-2017, Nathan Williams <nath.e.will@gmail.com>
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
  #
  # configure
  #
  nomad['data_dir'] = '/var/lib/nomad'
  nomad['atlas_join'] = false
  nomad['client_enabled'] = true
  nomad['server_enabled'] = false

  #
  # install
  #
  nomad['source_url'] = 'https://releases.hashicorp.com/nomad'
  nomad['package'], nomad['checksum'] =
    case node['os']
    when 'mac_os_x'
      %w(
        0.6.0/nomad_0.6.0_darwin_amd64.zip
        aebaeb1ad675cd9f1ac3b5270b153eae85bc4e764133b9063c66427df22a11a0
      )
    when 'windows'
      %w(
        0.6.0/nomad_0.6.0_windows_amd64.zip
        2249cd1adafa1a501671b81760ba3a8e349e939d4c5bbb1c28e509d5ad780df0
      )
    else
      %w(
        0.6.0/nomad_0.6.0_linux_amd64.zip
        fcf108046164cfeda84eab1c3047e36ad59d239b66e6b2f013e6c93064bc6313
      )
    end

  #
  # manage
  #
  nomad['daemon_args'].tap do |args|
    args['config'] = Nomad::Helpers::CONFIG_ROOT
  end
end
