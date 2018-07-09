resource_name :nomad_tls_config
provides :nomad_tls_config

property :tls_name, String, name_property: true, identity: true
NomadCookbook::TLSConfig::OPTIONS.each do |opt, conf|
  property opt, conf
end

%i(create delete).each do |actn|
  action actn do
    directory NomadCookbook::Helpers::CONFIG_ROOT do
      not_if { new_resource.action == :delete }
    end

    file ::File.join(NomadCookbook::Helpers::CONFIG_ROOT,
                     "#{new_resource.tls_name}.tls.json") do
      content(JSON.pretty_generate(
                {
                  tls: NomadCookbook::Helpers
                         .property_hash(new_resource, NomadCookbook::TLSConfig::OPTIONS),
                }, quirks_mode: true)
             )
      action actn
    end
  end
end
