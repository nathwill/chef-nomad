resource_name :nomad_config
provides :nomad_config

property :config_name, String, name_property: true, identity: true
NomadCookbook::Config::OPTIONS.each do |opt, conf|
  property opt, conf
end

%i[create delete].each do |actn|
  action actn do
    file ::File.join(NomadCookbook::Helpers::CONFIG_ROOT, new_resource.config_name) do
      content NomadCookbook::Helpers.property_hash(self, NomadCookbook::Config::OPTIONS)
      action actn
    end
  end
end
