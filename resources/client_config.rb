resource_name :nomad_client_config
provides :nomad_client_config

property :client_name, String, name_property: true, identity: true
NomadCookbook::ClientConfig::OPTIONS.each do |opt, conf|
  property opt, conf
end

%i[create delete].each do |actn|
  action actn do
    file ::File.join(NomadCookbook::Helpers::CONFIG_ROOT, new_resource.client_name) do
      content NomadCookbook::Helpers.property_hash(self, NomadCookbook::ClientConfig::OPTIONS)
      action actn
    end
  end
end
