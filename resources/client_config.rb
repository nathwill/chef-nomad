resource_name :nomad_client_config
provides :nomad_client_config

property :client_name, String, name_property: true, identity: true
NomadCookbook::ClientConfig::OPTIONS.each do |opt, conf|
  property opt, conf
end

%i[create delete].each do |actn|
  action actn do
    directory NomadCookbook::Helpers::CONFIG_ROOT do
      not_if { new_resource.action == :delete }
    end

    file ::File.join(NomadCookbook::Helpers::CONFIG_ROOT, new_resource.client_name) do
      content NomadCookbook::Helpers
        .property_hash(self, NomadCookbook::ClientConfig::OPTIONS)
        .to_json
      action actn
    end
  end
end
