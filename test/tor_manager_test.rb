require 'test_helper'

class TorManagerTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::TorManager::VERSION
  end

  def test_fetch_ip_address
    real_ip = TorManager::Tor.fetch_ip_address(real_ip: true)
    puts "Real IP: #{real_ip}"

    tor_ip = TorManager::Tor.fetch_ip_address
    puts "Tor IP: #{tor_ip}"
  end

  def test_switch_tor_endpoint
    tor_ip = TorManager::Tor.fetch_ip_address
    puts "Tor IP (before): #{tor_ip}"

    TorManager::Tor.switch_tor_endpoint!

    tor_ip = TorManager::Tor.fetch_ip_address
    puts "Tor IP (after): #{tor_ip}"
  end

  def test_get_user_agent
    puts "Get random user agent: #{TorManager::Tor.get_random_user_agent}"
  end

  def test_simple_http_get
    query = TorManager::Tor.get('https://www.google.fr/')
    puts "HTTP Code: #{query.code}"
    puts "HTTP Body Size: #{query.body.size}"
  end
end
