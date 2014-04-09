RSpec::Matchers.define :be_a_phone do |expected|
  match do |actual|
    if actual.respond_to? :keys
      actual.keys.map(&:to_sym).sort == [
        :id,
        :number,
        :primary,
        :type
      ]
    else
      false
    end
  end
end