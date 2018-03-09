module TorManager
  class Error < RuntimeError; end
  class AuthenticationError < Error; end
  class RouteSwitchingError < Error; end
end
