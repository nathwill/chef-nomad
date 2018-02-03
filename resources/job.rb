resource_name :nomad_job
provides :nomad_job

property :job_name, String, name_property: true, identity: true
property :cookbook, kind_of: String
property :path, kind_of: String, default: NomadCookbook::Helpers::JOB_ROOT
property :source, kind_of: String, required: true
property :variables, kind_of: Hash

default_action :create

action_class do
  def job_file
    ::File.join(new_resource.path, "#{new_resource.job_name}.hcl")
  end

  def nomad_bin
    '/usr/local/bin/nomad'
  end
end

%i[create delete].each do |actn|
  action actn do
    directory new_resource.path do
      not_if { new_resource.action == :delete }
    end

    template job_file do
      cookbook new_resource.cookbook || new_resource.cookbook_name
      source new_resource.source
      variables new_resource.variables if new_resource.variables
      action actn
      verify { |path| "#{nomad_bin} validate #{path}" } if respond_to?(:verify)
    end
  end
end

action :run do
  execute "#{nomad_bin} run #{job_file}"
end

action :stop do
  execute "#{nomad_bin} stop #{new_resource.job_name}"
end
