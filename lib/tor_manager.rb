module TorManager
  if defined?(Rails)
    require 'tor_manager/engine'
  else
    require 'tor_manager/version'
    require 'tor_manager/tor'
    require 'tor_manager/error'
  end
end
