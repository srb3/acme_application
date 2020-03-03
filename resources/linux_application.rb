property :name,                String, default: 'hello_world'
property :artifact_url,        String, default: 'http://www.java2s.com/Code/JarDownload/helloworld-spring/helloworld-spring-1.4.jar.zip'
property :env,                 String, default: 'development'
property :defl_code,           String, default: '1234'
property :jre_package,         String, default: lazy { node['acme_application']['jre_package'] }
property :artifact_extenstion, String, default: 'zip'
property :binary_extenstion,   String, default: 'jar'

resource_name :acme_application

action :create do
  package new_resource.jre_package do
    action :install
  end

  directory binary_dir do
    recursive true
  end

  remote_file archive_path do
    source new_resource.artifact_url
    notifies :extract, "archive_file[extract_#{new_resource.name}_app]"
  end

  archive_file "extract_#{new_resource.name}_app" do
    destination binary_dir
    overwrite true
    path archive_path
    notifies :restart, "service[acme_app.#{new_resource.name}]"
  end

  systemd_unit "acme_app.#{new_resource.name}.service" do
    content(
      Unit: {
        Description: "acme_app.#{new_resource.name}",
        After: 'syslog.target'
      },
      Service: {
        ExecStart: "/usr/bin/java -jar #{binary_path}"
      },
      Install: {
        WantedBy: 'multi-user.target'
      }
    )
    action :create
    notifies :restart, "service[acme_app.#{new_resource.name}]"
  end

  service "acme_app.#{new_resource.name}" do
    action [:enable, :start]
  end
end

action_class do
  def archive_path
    "#{Chef::Config[:file_cache_path]}/#{new_resource.name}.#{new_resource.artifact_extenstion}"
  end

  def binary_dir
    "/#{new_resource.env}/#{new_resource.defl_code}/#{new_resource.name}"
  end

  def binary_path
    "/#{binary_dir}/#{new_resource.name}.#{new_resource.binary_extenstion}"
  end
end
