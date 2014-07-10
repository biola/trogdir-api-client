module Trogdir
  module APIClient
    module Settings
      def self.included(base)
        base.send :domain, TrogdirAPIClient.config.base_url
        base.send :adapter, Weary::Adapter::NetHttpAdvanced
        base.send :use, Weary::Middleware::HMACAuth, [TrogdirAPIClient.config.credentials]
      end
    end
  end
end
