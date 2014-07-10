module Trogdir
  module APIClient
    class IDs < Weary::Client
      include Settings

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
