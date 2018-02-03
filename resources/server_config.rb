resource_name :nomad_server_config
provides :nomad_server_config

property :server_name, String, name_property: true, identity: true
NomadCookbook::ServerConfig::OPTIONS.each do |opt, conf|
  property opt, conf
end

%i[create delete].each do |actn|
  action actn do
    directory NomadCookbook::Helpers::CONFIG_ROOT do
      not_if { new_resource.action == :delete }
    end

    file ::File.join(NomadCookbook::Helpers::CONFIG_ROOT, new_resource.server_name) do
      content NomadCookbook::Helpers
        .property_hash(self, NomadCookbook::ServerConfig::OPTIONS)
        .to_json
      action actn
    end
  end
end
