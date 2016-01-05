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
        0.2.1/nomad_0.2.1_darwin_amd64.zip
        7f40f24c7c386bff4f97fad89c258ca7549d9629260d319a71a27fbb9e9ba31f
      )
    when 'windows'
      %w(
        0.2.1/nomad_0.2.1_windows_amd64.zip
        833fd3fd247ee80f38ed64a6900980833b32012785dc510896df1d4170052768
      )
    else
      %w(
        0.2.1/nomad_0.2.1_linux_amd64.zip
        a47881efc148cc37a8c94fb120c1d198371b9124e92668e8fc0badddef99cc2a
      )
    end
end
