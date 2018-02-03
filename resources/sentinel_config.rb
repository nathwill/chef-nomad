resource_name :nomad_sentinel_config
provides :nomad_sentinel_config

property :sentinel_name, String, name_property: true, identity: true
NomadCookbook::SentinelConfig::OPTIONS.each do |opt, conf|
  property opt, conf
end

%i[create delete].each do |actn|
  action actn do
    directory NomadCookbook::Helpers::CONFIG_ROOT do
      not_if { new_resource.action == :delete }
    end

    file ::File.join(NomadCookbook::Helpers::CONFIG_ROOT, new_resource.sentinel_name) do
      content NomadCookbook::Helpers
        .property_hash(self, NomadCookbook::SentinelConfig::OPTIONS)
        .to_json
      action actn
    end
  end
end
