module Trogdir
  module APIClient
    class Photos < Weary::Client
      domain TrogdirAPIClient.config.base_url
      use Weary::Middleware::HMACAuth, [TrogdirAPIClient.config.credentials]

      get :index, '/people/{uuid}/photos'

      get :show, '/people/{uuid}/photos/{photo_id}'

      post :create, '/people/{uuid}/photos' do |resource|
        resource.required :type, :url, :height, :width
      end

      put :update, '/people/{uuid}/photos/{photo_id}' do |resource|
        resource.optional :type, :url, :width, :height
      end

      delete :destroy, '/people/{uuid}/photos/{photo_id}'
    end
  end
end