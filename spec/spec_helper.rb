$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')
$:.unshift File.expand_path(File.dirname(__FILE__))

ENV['RACK_ENV'] = 'test'

require 'bundler/setup'
require 'oj'
require 'rspec'
require 'webmock/rspec'
require 'factory_girl'
require 'faker'
require 'trogdir_api'
require 'trogdir_api_client'
require 'pry'

TrogdirAPI.initialize!

TrogdirModels.load_factories
FactoryGirl.find_definitions

Dir[File.expand_path('../support/*.rb', __FILE__)].each { |f| require f }

TrogdirAPIClient.configure do |config|
  config.script_name = nil
  config.access_id = SyncinatorHelpers.access_id
  config.secret_key = SyncinatorHelpers.secret_key
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include SyncinatorHelpers

  config.before do
    stub_request(:any, /.*/).to_rack Trogdir::API
  end

  # Clean/Reset Mongoid DB prior to running each test.
  config.before(:each) do
    Mongoid::Sessions.default.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end
