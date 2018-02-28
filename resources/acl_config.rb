resource_name :nomad_acl_config
provides :nomad_acl_config

property :acl_name, String, name_property: true, identity: true
NomadCookbook::ACLConfig::OPTIONS.each do |opt, conf|
  property opt, conf
end

%i(create delete).each do |actn|
  action actn do
    directory NomadCookbook::Helpers::CONFIG_ROOT do
      not_if { new_resource.action == :delete }
    end

    file ::File.join(NomadCookbook::Helpers::CONFIG_ROOT,
                     "#{new_resource.acl_name}.acl.json") do
      content({
        acl: NomadCookbook::Helpers
               .property_hash(new_resource, NomadCookbook::ACLConfig::OPTIONS),
      }.to_json)
      action actn
    end
  end
end
