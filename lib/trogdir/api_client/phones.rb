module Trogdir
  module APIClient
    class Phones < Weary::Client
      include Settings

      get :index, '/people/{uuid}/phones'

      get :show, '/people/{uuid}/phones/{phone_id}'

      post :create, '/people/{uuid}/phones' do |resource|
        resource.required :type, :number
        resource.optional :primary
      end

      put :update, '/people/{uuid}/phones/{phone_id}' do |resource|
        resource.optional :type, :number, :primary
      end

      delete :destroy, '/people/{uuid}/phones/{phone_id}'
    end
  end
end
