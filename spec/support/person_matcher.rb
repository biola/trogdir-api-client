RSpec::Matchers.define :be_a_person do |expected|
  match do |actual|
    if actual.respond_to? :keys
      actual.keys.map(&:to_sym).sort == [
        :addresses,
        :affiliations,
        :birth_date,
        :department,
        :display_name,
        :emails,
        :employee_type,
        :enabled,
        :entitlements,
        :first_name,
        :floor,
        :full_time,
        :gender,
        :groups,
        :ids,
        :job_ct,
        :last_name,
        :mailbox,
        :majors,
        :middle_name,
        :minors,
        :partial_ssn,
        :pay_type,
        :phones,
        :photos,
        :preferred_name,
        :privacy,
        :residence,
        :title,
        :uuid,
        :wing
      ]
    else
      false
    end
  end
end
