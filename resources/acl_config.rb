resource_name :nomad_acl_config
provides :nomad_acl_config

property :acl_name, String, name_property: true, identity: true
NomadCookbook::ACLConfig::OPTIONS.each do |opt, conf|
  property opt, conf
end

%i[create delete].each do |actn|
  action actn do
    file ::File.join(NomadCookbook::Helpers::CONFIG_ROOT, new_resource.acl_name) do
      content NomadCookbook::Helpers.property_hash(self, NomadCookbook::ACLConfig::OPTIONS)
      action actn
    end
  end
end
