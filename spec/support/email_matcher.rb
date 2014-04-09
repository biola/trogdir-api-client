RSpec::Matchers.define :be_an_email do |expected|
  match do |actual|
    if actual.respond_to? :keys
      actual.keys.map(&:to_sym).sort == [
        :address,
        :id,
        :primary,
        :type
      ]
    else
      false
    end
  end
end