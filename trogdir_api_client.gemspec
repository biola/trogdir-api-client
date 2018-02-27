lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'trogdir_api_client/version'

spec = Gem::Specification.new do |s|
  s.name = 'trogdir_api_client'
  s.version = TrogdirAPIClient::VERSION
  s.summary = 'Client for the Trogdir directory API'
  s.description = 'API consuming models for the Trogdir directory project'
  s.files = Dir['README.*', 'MIT-LICENSE', 'lib/**/*.rb']
  s.require_path = 'lib'
  s.author = 'Adam Crownoble'
  s.email = 'adam.crownoble@biola.edu'
  s.homepage = 'https://github.com/biola/trogdir-api-client'
  s.license = 'MIT'
  # After all of the syncinators are using 2.0 bump this to '~> 2.0'
  s.add_dependency 'api-auth', '>= 1.3'
  s.add_dependency 'weary'
  s.add_development_dependency 'rspec', '~> 2.14'
  s.add_development_dependency 'webmock', '~> 1.17'
  s.add_development_dependency 'factory_girl', '~> 4.4'
  s.add_development_dependency 'faker', '~> 1.3'
  # The trogdir_api gem is added for testing purposes.
  s.add_development_dependency 'trogdir_api'
  s.add_development_dependency 'pry', '~> 0.9'
  s.add_development_dependency 'pry-stack_explorer', '~> 0.4'
end
