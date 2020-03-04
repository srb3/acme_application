Ohai.plugin(:AcmePackages) do
  provides 'acme_packages'

  def get_packages(env)
    ::Dir.glob("/#{env}/*/*") - ['.', '..']
  end

  collect_data(:default) do
    acme_packages Mash.new
    %w{ DEV TST GTU TGT UAT PTP PRD }.each do |env|
      acme_packages[env] = get_packages(env)
    end
  end
end
