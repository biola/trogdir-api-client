module Trogdir
  module APIClient
    class Addresses < Weary::Client
      domain TrogdirAPIClient.config.base_url
      use Weary::Middleware::HMACAuth, [TrogdirAPIClient.config.credentials]

      get :index, '/people/{uuid}/addresses'

      get :show, '/people/{uuid}/addresses/{address_id}'

      post :create, '/people/{uuid}/addresses' do |resource|
        resource.required :type, :street_1
        resource.optional :street_2, :city, :state, :zip, :country
      end

      put :update, '/people/{uuid}/addresses/{address_id}' do |resource|
        resource.optional :type, :street_1, :street_2, :city, :state, :zip, :country
      end

      delete :destroy, '/people/{uuid}/addresses/{address_id}'
    end
  end
end