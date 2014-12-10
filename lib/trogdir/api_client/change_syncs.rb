module Trogdir
  module APIClient
    class ChangeSyncs < Weary::Client
      include Settings

      put :start, '/change_syncs/start' do |resource|
        resource.optional :limit
      end

      put :start_one, '/change_syncs/start/{changeset_id}'

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
