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
    autoload :Accounts, 'trogdir/api_client/accounts'
    autoload :Addresses, 'trogdir/api_client/addresses'
    autoload :ChangeSyncs, 'trogdir/api_client/change_syncs'
    autoload :Emails, 'trogdir/api_client/emails'
    autoload :Groups, 'trogdir/api_client/groups'
    autoload :IDs, 'trogdir/api_client/ids'
    autoload :People, 'trogdir/api_client/people'
    autoload :Phones, 'trogdir/api_client/phones'
    autoload :Photos, 'trogdir/api_client/photos'
    autoload :Settings, 'trogdir/api_client/settings'
  end
end

module Weary
  module Middleware
    autoload :HMACAuth, 'weary/middleware/hmac_auth'
  end

  module Adapter
    autoload :NetHttpAdvanced, 'weary/adapters/net_http_advanced'
  end
end
