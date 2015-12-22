module Trogdir
  module APIClient
    class People < Weary::Client
      include Settings

      get :index, '/people' do |resource|
        resource.optional :affiliation
      end

      get :show, '/people/{uuid}'

      get :by_id, '/people/by_id/{id}' do |resource|
        resource.optional :type
      end

      post :create, '/people' do |resource|
        resource.required :first_name, :last_name
        resource.optional(
          :preferred_name, :middle_name, :display_name, # Names
          :gender, :partial_ssn, :birth_date,           # Demographic
          :entitlements, :affiliations, :groups,        # Groups and permissions

          # STUDENT INFO #
          :residence, :floor, :wing, :mailbox, # On-Campus Residence
          :majors, :minors,                    # Academic
          :privacy,                            # FERPA

          # EMPLOYEE INFO #
          :department, :title, :employee_type, :full_time, :pay_type, :job_ct
        )
      end

      put :update, '/people/{uuid}' do |resource|
        resource.optional(
          :first_name, :last_name, :preferred_name, :middle_name, :display_name,  # Names
          :gender, :partial_ssn, :birth_date,                                     # Demographic
          :entitlements, :affiliations, :groups,                                  # Groups and permissions

          # STUDENT INFO #
          :residence, :floor, :wing, :mailbox, # On-Campus Residence
          :majors, :minors,                    # Academic
          :privacy,                            # FERPA

          # EMPLOYEE INFO #
          :department, :title, :employee_type, :full_time, :pay_type, :job_ct
        )
      end
    end
  end
end
