RSpec::Matchers.define :be_an_id do |expected|
  match do |actual|
    if actual.respond_to? :keys
      actual.keys.map(&:to_sym).sort == [
        :id,
        :identifier,
        :type,
      ]
    else
      false
    end
  end
end