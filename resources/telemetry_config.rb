resource_name :nomad_telemetry_config
provides :nomad_telemetry_config

property :telemetry_name, String, name_property: true, identity: true
NomadCookbook::TelemetryConfig::OPTIONS.each do |opt, conf|
  property opt, conf
end

%i[create delete].each do |actn|
  action actn do
    file ::File.join(NomadCookbook::Helpers::CONFIG_ROOT, new_resource.telemetry_name) do
      content NomadCookbook::Helpers.property_hash(self, NomadCookbook::TelemetryConfig::OPTIONS)
      action actn
    end
  end
end
