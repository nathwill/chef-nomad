#
# Cookbook Name:: nomad
# Attributes:: install
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
  nomad['source_url'] = 'https://releases.hashicorp.com/nomad'
  nomad['package'], nomad['checksum'] =
    case node['os']
    when 'mac_os_x'
      %w(
        0.5.5/nomad_0.5.5_darwin_amd64.zip
        e20f768c7a78332a0875f0ded3743f398886ffbb85dbf51f7117ac2a4068d208
      )
    when 'windows'
      %w(
        0.5.5/nomad_0.5.5_windows_amd64.zip
        98b0d65da887a0e54fe35b8f192963f0f43901b5e2bfae44e9f9a816721515e8
      )
    else
      %w(
        0.5.5/nomad_0.5.5_linux_amd64.zip
        13ecd22bbbffab5b8261c2146af54fdf96a22c46c6618d6b5fd0f61938b95068
      )
    end
end
