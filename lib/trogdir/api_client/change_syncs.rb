module Trogdir
  module APIClient
    class ChangeSyncs < Weary::Client
      domain TrogdirAPIClient.config.base_url
      use Weary::Middleware::HMACAuth, [TrogdirAPIClient.config.credentials]

      put :start, '/change_syncs/start'

      put :error, '/change_syncs/error/{sync_log_id}' do |resource|
        resource.required :message
      end

      put :finish, '/change_syncs/finish/{sync_log_id}' do |resource|
        resource.required :action
        resource.optional :message
      end
    end
  end
end