require "test_helper"

class TorManagerTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::TorManager::VERSION
  end

  def test_it_does_something_useful
    tor_manager = TorManager.start!
    puts "IP: #{tor_manager.get_current_ip_address}"
    puts 'Change IP address...'

    tor_manager.switch_endpoint
    puts "IP: #{tor_manager.get_current_ip_address}"
  end
end
