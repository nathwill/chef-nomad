
default['nomad'].tap do |nomad|
  nomad['source_url'] = 'https://dl.bintray.com/mitchellh/nomad'
  nomad['package'], nomad['checksum'] =
    case node['os']
    when 'linux'
      %w(
        nomad_0.1.0_linux_amd64.zip
        0c41b5b804089e3f776998fb6e03815e9862580ca953dd39ee822d71fde51e70
      )
    when 'mac_os_x'
      %w(
        nomad_0.1.0_darwin_amd64.zip
        bea96ca7fcb4e6ce446ab86c26770f4b2dbaf936e299355831e9a383d67b4849
      )
    when 'windows'
      %w(
        nomad_0.1.0_windows_amd64.zip
        f0d11709e1e204187fa9d9c4135710f4a1e48d8603651cac87c3f22426ba0d71
      )
    else
      Chef::Log.fatal!("Unsupported platform!")
    end
end
