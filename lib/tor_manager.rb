require 'tor_manager/version'
require 'tor_manager/manager'
require 'tor_manager/error'
require 'net/telnet'
require 'socksify/http'
require 'mechanize'

module TorManager
  def self.start!
    Manager.new
  end
end
