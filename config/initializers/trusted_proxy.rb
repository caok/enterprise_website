# hack trusted proxy
module Rack
  class Request
    def trusted_proxy?(ip)
      ip == '127.0.0.1'
    end
  end
end

module ActionDispatch
  class RemoteIp
    # hack for trusted proxies
    def proxies
      /^127\.0\.0\.1$/
    end
  end
end
