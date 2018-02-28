resource_name :nomad_vault_config
provides :nomad_vault_config

property :vault_name, String, name_property: true, identity: true
NomadCookbook::VaultConfig::OPTIONS.each do |opt, conf|
  property opt, conf
end

%i(create delete).each do |actn|
  action actn do
    directory NomadCookbook::Helpers::CONFIG_ROOT do
      not_if { new_resource.action == :delete }
    end

    file ::File.join(NomadCookbook::Helpers::CONFIG_ROOT,
                     "#{new_resource.vault_name}.vault.json") do
      content({
        vault: NomadCookbook::Helpers
                 .property_hash(new_resource,
                                NomadCookbook::VaultConfig::OPTIONS),
      }.to_json)
      action actn
    end
  end
end
