module Trogdir
  module APIClient
    class Accounts < Weary::Client
      include Settings

      get :index, '/people/{uuid}/account'

      get :show, '/people/{uuid}/account/{account_id}'

      post :create, '/people/{uuid}/account/' do |resource|
        resource.required :_type
      end

      # TODO: figure out what should be updateable
      put :update, '/people/{uuid}/account/{account_id}' do |resource|
        resource.required :account_id
        resource.optional :_type, :modified_by, :confirmation_key, :confirmed_at
      end

      delete :destroy, '/people/{uuid}/account/{account_id}'
    end
  end
end
