name 'acme_application'
maintainer 'Steve Brown'
maintainer_email 'sbrown@chef.io'
license 'Apache-2.0'
description 'Installs/Configures acme_application'
long_description 'Installs/Configures acme_application'
version '0.1.0'
chef_version '>= 14.0'

%w(centos).each do |os|
  supports os
end


issues_url 'https://github.com/srb3/acme_application/issues'
source_url 'https://github.com/srb3/acme_application'
