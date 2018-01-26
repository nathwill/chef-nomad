resource_name :nomad_server_config
provides :nomad_server_config

property :server_name, String, name_property: true, identity: true
NomadCookbook::ServerConfig::OPTIONS.each do |opt, conf|
  property opt, conf
end

%i[create delete].each do |actn|
  action actn do
    file ::File.join(NomadCookbook::Helpers::CONFIG_ROOT, new_resource.server_name) do
      content NomadCookbook::Helpers.property_hash(self, NomadCookbook::ServerConfig::OPTIONS)
      action actn
    end
  end
end
