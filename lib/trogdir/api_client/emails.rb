module Trogdir
  module APIClient
    class Emails < Weary::Client
      include Settings

      get :index, '/people/{uuid}/emails'

      get :show, '/people/{uuid}/emails/{email_id}'

      post :create, '/people/{uuid}/emails' do |resource|
        resource.required :type, :address
        resource.optional :primary
      end

      put :update, '/people/{uuid}/emails/{email_id}' do |resource|
        resource.optional :type, :address, :primary
      end

      delete :destroy, '/people/{uuid}/emails/{email_id}'
    end
  end
end
