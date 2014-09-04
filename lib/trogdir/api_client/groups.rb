module Trogdir
  module APIClient
    class Groups < Weary::Client
      include Settings

      get :people, '/groups/{group}/people'

      put :add, '/groups/{group}/add' do |resource|
        resource.required :identifier
        resource.optional :type
      end

      put :remove, '/groups/{group}/remove' do |resource|
        resource.required :identifier
        resource.optional :type
      end
    end
  end
end
