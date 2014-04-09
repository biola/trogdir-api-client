RSpec::Matchers.define :be_a_photo do |expected|
  match do |actual|
    if actual.respond_to? :keys
      actual.keys.map(&:to_sym).sort == [
        :height,
        :id,
        :type,
        :url,
        :width
      ]
    else
      false
    end
  end
end