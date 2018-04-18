resource_name :nomad_job
provides :nomad_job

property :job_name, String, name_property: true, identity: true
property :cookbook, String
property :path, String, default: NomadCookbook::Helpers::JOB_ROOT
property :source, String, required: true
property :variables, Hash

default_action :create

action_class do
  def job_file
    ::File.join(new_resource.path, "#{new_resource.job_name}.hcl")
  end

  def nomad_bin
    '/usr/local/sbin/nomad'
  end
end

%i(create delete).each do |actn|
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
