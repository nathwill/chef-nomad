resource_name :nomad_plugin_config
provides :nomad_plugin_config

property :plugin_name, String, name_property: true, identity: true
NomadCookbook::PluginConfig::OPTIONS.each do |opt, conf|
  property opt, conf.delete(:kind_of), **conf
end

unified_mode true

%i(create delete).each do |actn|
  action actn do
    directory NomadCookbook::Helpers::CONFIG_ROOT do
      not_if { new_resource.action == :delete }
    end

    file ::File.join(NomadCookbook::Helpers::CONFIG_ROOT,
                     "#{new_resource.plugin_name}.plugin.json") do
      content(JSON.pretty_generate(
                {
                  plugin: [{
                    new_resource.plugin_name => [
                      NomadCookbook::Helpers
                         .property_hash(new_resource, NomadCookbook::PluginConfig::OPTIONS),
                    ],
                  }],
                }, quirks_mode: true)
             )
      action actn
    end
  end
end
