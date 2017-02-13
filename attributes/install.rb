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
        0.5.4/nomad_0.5.4_darwin_amd64.zip
        f213415d09236edd39faccffa33851acd239048372561766eeb6e9f6b73fd14f
      )
    when 'windows'
      %w(
        0.5.4/nomad_0.5.4_windows_amd64.zip
        c235986772659ba0939d8686c575cc73ddff9e400bbf90e510ad88b0f303d463
      )
    else
      %w(
        0.5.4/nomad_0.5.4_linux_amd64.zip
        ed9eb471b9f5bab729cfa402db5aa56e1d935c328ac48327267e0ea53568d5c2
      )
    end
end
