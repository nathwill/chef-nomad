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
        0.4.1/nomad_0.4.1_darwin_amd64.zip
        5f2d52c73e992313e803fb29b6957ad1b754ed6e68bed5fa9fbe9b8e10a67aeb
      )
    when 'windows'
      %w(
        0.4.1/nomad_0.4.1_windows_amd64.zip
        9940bf71b970df2c9e89ffb8307976a2c2e1d256e80da3767b36d3110594b969
      )
    else
      %w(
        0.4.1/nomad_0.4.1_linux_amd64.zip
        0cdb5dd95c918c6237dddeafe2e9d2049558fea79ed43eacdfcd247d5b093d67
      )
    end
end
