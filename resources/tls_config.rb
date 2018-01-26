resource_name :nomad_tls_config
provides :nomad_tls_config

property :tls_name, String, name_property: true, identity: true
NomadCookbook::TLSConfig::OPTIONS.each do |opt, conf|
  property opt, conf
end

%i[create delete].each do |actn|
  action actn do
    file ::File.join(NomadCookbook::Helpers::CONFIG_ROOT, new_resource.tls_name) do
      content NomadCookbook::Helpers.property_hash(self, NomadCookbook::TLSConfig::OPTIONS)
      action actn
    end
  end
end
