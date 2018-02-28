resource_name :nomad_telemetry_config
provides :nomad_telemetry_config

property :telemetry_name, String, name_property: true, identity: true
NomadCookbook::TelemetryConfig::OPTIONS.each do |opt, conf|
  property opt, conf
end

%i(create delete).each do |actn|
  action actn do
    directory NomadCookbook::Helpers::CONFIG_ROOT do
      not_if { new_resource.action == :delete }
    end

    file ::File.join(NomadCookbook::Helpers::CONFIG_ROOT,
                     "#{new_resource.telemetry_name}.telemetry.json") do
      content({
        telemetry: NomadCookbook::Helpers
                     .property_hash(new_resource,
                                    NomadCookbook::TelemetryConfig::OPTIONS),
      }.to_json)
      action actn
    end
  end
end
