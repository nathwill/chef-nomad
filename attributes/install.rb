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
        0.3.1/nomad_0.3.1_darwin_amd64.zip
        c300a3b5c195fbccf26dfcdb756b4c953ca0e5e566a41fce1d10ef1947ec4279
      )
    when 'windows'
      %w(
        0.3.1/nomad_0.3.1_windows_amd64.zip
        85fb5ddbf4e8ae838084235e61360e827041dc330dc5dc9b50da663844befc43
      )
    else
      %w(
        0.3.1/nomad_0.3.1_linux_amd64.zip
        467fcebe9f0a349063a4f16c97cb71d9c57451fc1f10cdb2292761cf56542671
      )
    end
end
