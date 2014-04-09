module Trogdir
  module APIClient
    class IDs < Weary::Client
      domain TrogdirAPIClient.config.base_url
      # use Weary::Middleware::ContentType
      use Weary::Middleware::HMACAuth, [TrogdirAPIClient.config.credentials]

      get :index, '/people/{uuid}/ids'

      get :show, '/people/{uuid}/ids/{id_id}'

      post :create, '/people/{uuid}/ids' do |resource|
        resource.required :type, :identifier
      end

      put :update, '/people/{uuid}/ids/{id_id}' do |resource|
        resource.optional :type, :identifier
      end

      delete :destroy, '/people/{uuid}/ids/{id_id}'
    end
  end
end