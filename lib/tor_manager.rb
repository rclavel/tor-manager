require 'tor_manager/version'
require 'tor_manager/manager'
require 'tor_manager/error'

module TorManager
  def self.start!
    Manager.new
  end
end
