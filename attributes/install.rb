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
        0.3.2/nomad_0.3.2_darwin_amd64.zip
        96808b9b8056490026327bdc6614e1813cee7d42978676e0024085709fd3fcac
      )
    when 'windows'
      %w(
        0.3.2/nomad_0.3.2_windows_amd64.zip
        d303e1feb251775ee694c7115de9bcd34271cf5c90bcfc0f92520197c106cd8b
      )
    else
      %w(
        0.3.2/nomad_0.3.2_linux_amd64.zip
        710ff3515bc449bc2a06652464f4af55f1b76f63c77a9048bc30d6fde284b441
      )
    end
end
