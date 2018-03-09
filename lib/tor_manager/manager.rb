class TorManager::Manager
  def initialize(control_port = 9051, socks_port = 9050)
    @tor_control_port = control_port
    @tor_socks_port = socks_port
    ::TCPSocket::socks_server = '127.0.0.1'
    ::TCPSocket::socks_port = @tor_socks_port
    puts '[TorManager] Initialize Tor Manager'
  end

  def get_current_ip_address
    puts '[TorManager] Get IP address'
    agent.get('http://monip.org').body.match(/IP : (?<ip>[0-9\.]+)/)[:ip]
  rescue Net::HTTP::Persistent::Error
    puts '[TorManager] Net::HTTP::Persistent::Error while getting IP address'
    kill_tor_and_restart
    retry
  rescue Exception => e
    puts '[TorManager] Error while getting IP address'
    puts e.message
    puts e.backtrace.join("\n")
    sleep 10
    retry
  end

  def switch_endpoint
    puts '[TorManager] Switch endpoint: Authenticate'
    localhost = Net::Telnet::new 'Host' => 'localhost', 'Port' => @tor_control_port, 'Timeout' => 10, 'Prompt' => /250 OK\n/
    localhost.cmd 'AUTHENTICATE ""' do |response|
      raise AuthenticationError if response != "250 OK\n"
    end
    puts '[TorManager] Switch endpoint: Switch route'
    localhost.cmd 'signal NEWNYM' do |response|
      raise RouteSwitchingError if response != "250 OK\n"
    end
    localhost.close
    puts '[TorManager] Wait for new IP...'
    sleep 5
  rescue Errno::ECONNREFUSED
    puts '[TorManager] Connection refused'
    kill_tor_and_restart
    retry
  rescue Exception => e
    puts '[TorManager] Error while switching endpoint'
    puts e.message
    puts e.backtrace.join("\n")
    sleep 10
    retry
  end

  def kill_tor_and_restart
    puts '[TorManager] Kill tor'
    `killall -9 tor`
    sleep 5
    puts '[TorManager] Restart tor'
    puts `tor --controlport #{tor_control_port} --SocksPort #{tor_socks_port}`
    sleep 5
  end

  private

  def agent
    @agent ||= Mechanize.new
  end
end
