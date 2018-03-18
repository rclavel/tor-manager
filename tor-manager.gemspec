
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tor_manager/version'

Gem::Specification.new do |spec|
  spec.name          = 'tor_manager'
  spec.version       = TorManager::VERSION
  spec.authors       = ['Romain Clavel']
  spec.email         = ['romain@clavel.io']

  spec.summary       = %q{A simple Tor Manager}
  spec.description   = %q{A simple Tor Manager that requires Tor to be already installed.}
  spec.homepage      = 'https://www.github.com/rclavel/tor-manager'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files lib/ -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'

  spec.add_runtime_dependency 'net-telnet', '~> 0.1.1'
  spec.add_runtime_dependency 'socksify', '~> 1.7.1'
end
