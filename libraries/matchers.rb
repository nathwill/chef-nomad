if defined?(ChefSpec)
  %w(job config server_config client_config atlas_config).each do |r|
    ChefSpec.define_matcher("nomad_#{r}".to_sym)

    %w(create delete).each do |action|
      define_method("#{action}_nomad_#{r}".to_sym) do |resource_name|
        ChefSpec::Matchers::ResourceMatcher.new(
          "nomad_#{r}".to_sym,
          action, resource_name
        )
      end
    end
  end

  %w(run stop).each do |job_action|
    define_method("#{job_action}_nomad_job".to_sym) do |resource_name|
      ChefSpec::Matchers::ResourceMatcher.new(:nomad_job, job_action, resource_name) # rubocop: disable LineLength
    end
  end
end
