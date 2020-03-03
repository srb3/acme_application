# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

name 'acme_application'

default_source :supermarket

run_list 'acme_application::default'
named_run_list :test, 'acme_application::test'

cookbook 'acme_application', path: '.'
