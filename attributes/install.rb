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
  nomad['source_url'] = 'https://dl.bintray.com/mitchellh/nomad'
  nomad['package'], nomad['checksum'] =
    case node['os']
    when 'mac_os_x'
      %w(
        nomad_0.1.2_darwin_amd64.zip
        8fcff1029c6cc9bf24ee441d749ef1039a6132e62ef486561a8a8d9e6e519fbf
      )
    when 'windows'
      %w(
        nomad_0.1.2_windows_amd64.zip
        920d46687bb6adcf458c2dd2ad0956e36c9be18ebd4fa9cfd41d8461262f70fc
      )
    else
      %w(
        nomad_0.1.2_linux_amd64.zip
        3335f7acb0d5eacaaa19aea37d128418ace18e6ef03d38de0c2c52ce831d7934
      )
    end
end
