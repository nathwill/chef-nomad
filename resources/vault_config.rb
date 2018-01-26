resource_name :nomad_vault_config
provides :nomad_vault_config

property :vault_name, String, name_property: true, identity: true
NomadCookbook::VaultConfig::OPTIONS.each do |opt, conf|
  property opt, conf
end

%i[create delete].each do |actn|
  action actn do
    file ::File.join(NomadCookbook::Helpers::CONFIG_ROOT, new_resource.vault_name) do
      content NomadCookbook::Helpers.property_hash(self, NomadCookbook::VaultConfig::OPTIONS)
      action actn
    end
  end
end
