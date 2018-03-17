require 'net/telnet'
require 'socksify/http'

class TorManager::Tor
  class << self
    TOR_SOCKS_SERVER = '127.0.0.1'
    TOR_SOCKS_PORT = 9050
    TOR_CONTROL_PORT = 9051

    # Source: https://gist.github.com/enginnr/ed572cf5c324ad04ff2e
    USER_AGENTS = File.read(File.join(File.dirname(__FILE__), 'user_agent_list.txt')).split("\n")

    def start(host, port, req_options = {}, &block)
      Net::HTTP
        .SOCKSProxy(TOR_SOCKS_SERVER, TOR_SOCKS_PORT)
        .start(host, port, req_options, &block)
    end

    def get_random_user_agent
      USER_AGENTS.sample
    end

    def switch_tor_endpoint!
      localhost = Net::Telnet::new(
        'Host' => 'localhost',
        'Port' => TOR_CONTROL_PORT,
        'Timeout' => 10,
        'Prompt' => /250 OK\n/
      )
      localhost.cmd('AUTHENTICATE ""') do |response|
        raise AuthenticationError if response != "250 OK\n"
      end
      localhost.cmd('signal NEWNYM') do |response|
        raise RouteSwitchingError if response != "250 OK\n"
      end
      localhost.close

      true
    end

    def fetch_ip_address(real_ip: false)
      uri = URI.parse('http://api.ipify.org/')
      response =
        if real_ip
          Net::HTTP.start(uri.host, uri.port) { |http| http.get(uri.path) }
        else
          start(uri.host, uri.port) { |http| http.get(uri.path) }
        end
      response.body
    end
  end
end
