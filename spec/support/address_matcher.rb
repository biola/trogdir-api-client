RSpec::Matchers.define :be_an_address do |expected|
  match do |actual|
    if actual.respond_to? :keys
      actual.keys.map(&:to_sym).sort == [
        :city,
        :country,
        :id,
        :state,
        :street_1,
        :street_2,
        :type,
        :zip
      ]
    else
      false
    end
  end
end