

%w( install configure manage ).each do |r|
  include_recipe "#{cookbook_name}::#{r}"
end