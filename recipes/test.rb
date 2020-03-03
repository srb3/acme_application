acme_application node['acme_application']['test_package_name'] do
  artifact_url node['acme_application']['test_package']
end

include_recipe 'acme_application::default'
