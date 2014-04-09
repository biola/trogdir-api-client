require 'weary'

module TrogdirAPIClient
  require 'trogdir_api_client/configuration'

  def self.configure
    yield config
  end

  def self.config
    @config ||= Configuration.new
  end
end

module Trogdir
  module APIClient
    autoload :People, 'trogdir/api_client/people'
    autoload :IDs, 'trogdir/api_client/ids'
    autoload :Emails, 'trogdir/api_client/emails'
    autoload :Phones, 'trogdir/api_client/phones'
  end
end

module Weary
  module Middleware
    autoload :HMACAuth, 'weary/middleware/hmac_auth'
  end
end