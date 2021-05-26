resource_name :nomad_audit_config
provides :nomad_audit_config

property :audit_name, String, name_property: true, identity: true
NomadCookbook::AuditConfig::OPTIONS.each do |opt, conf|
  property opt, conf.delete(:kind_of), **conf
end

unified_mode true

%i(create delete).each do |actn|
  action actn do
    directory NomadCookbook::Helpers::CONFIG_ROOT do
      not_if { new_resource.action == :delete }
    end

    file ::File.join(NomadCookbook::Helpers::CONFIG_ROOT,
                     "#{new_resource.audit_name}.audit.json") do
      content(JSON.pretty_generate(
                {
                  audit: NomadCookbook::Helpers
                         .property_hash(new_resource, NomadCookbook::AuditConfig::OPTIONS),
                }, quirks_mode: true)
             )
      action actn
    end
  end
end
