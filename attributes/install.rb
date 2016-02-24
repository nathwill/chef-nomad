#
# Cookbook Name:: nomad
# Attributes:: install
#
# Copyright 2015 The Authors
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
        0.2.3/nomad_0.2.3_darwin_amd64.zip
        ad7caf0641bb7be2aab0dd2496545461010cbc667a857aaac4f10b7296c59ca9
      )
    when 'windows'
      %w(
        0.2.3/nomad_0.2.3_windows_amd64.zip
        761996bf3c0296c07b503574cee08e41cb93e1c6412d2927ae0ca6567f91f921
      )
    else
      %w(
        0.2.3/nomad_0.2.3_linux_amd64.zip
        0f3a7083d160893a291b5f8b4359683c2df7991fa0a3e969f8785ddb40332a8c
      )
    end
end
