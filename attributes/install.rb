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
        0.2.0/nomad_0.2.0_darwin_amd64.zip
        1606cc268298852b0e413d3799843597a9aa0c47c53313ef2a523cc595ccb2f1
      )
    when 'windows'
      %w(
        0.2.0/nomad_0.2.0_windows_amd64.zip
        b2d25d22cb0511b9f2596f6b91a91796b96dd2124a6f0927bc91554f68681dcf
      )
    else
      %w(
        0.2.0/nomad_0.2.0_linux_amd64.zip
        f4525cbd99fd57ef607f9556be4f4bc39f82391947f40cc993538bba7da5bf90
      )
    end
end
