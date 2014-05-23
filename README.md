Trogdir API Client [![Build Status](https://travis-ci.org/biola/trogdir-api-client.svg?branch=master)](https://travis-ci.org/biola/trogdir-api-client)
==================

Installing
----------

Add `gem 'trogdir_api_client'` to your `Gemfile` and run `bundle`

Configuration
-------------

```ruby
TrogdirAPIClient.configure do |config|
  # Optional:
  # config.scheme = 'http'
  # config.host = 'localhost'
  # config.script_name = nil
  # config.version = 'v1'
  
  # Required:
  config.access_id = '**************'
  config.secret_key = '*****************************************'
end
```

Usage
-----

### Example Syncinator

```ruby
require 'trogdir_api_client'
require 'multi_json'

trogdir = Trogdir::APIClient::ChangeSyncs.new
hashes = trogdir.start.perform.parse

hashes.each do |hash|
  sync_log_id = hash['sync_log_id']
  action = hash['action']
  person_id = hash['person_id']
  scope = hash['scope']
  original = hash['original']
  modified = hash['modified']

  action_taken = 'nothing'

  begin
    person = Person.find(person_id)

    case scppe
    when 'person'
      case action
      when 'create'
        # do stuff
        action_taken = 'create'
      when 'update'
        # do stuff
        action_taken = 'update'
      when 'destroy'
        # do stuff
        action_taken = 'destroy'
      end
    when 'id'
      case action
      when 'create'
        # do stuff
        action_taken = 'create'
      when 'update'
        # do stuff
        action_taken = 'update'
      when 'destroy'
        # do stuff
        action_taken = 'destroy'
      end
    when 'email'
      # blah
    when 'photo'
      # blah
    when 'phone'
      # blah
    when 'address'
      # blah
    end

    trogdir.finish(sync_log_id: sync_log_id, action: action_taken).perform
  rescue StandardError => err
    trogdir.error(sync_log_id: sync_log_id, message: err.message).perform
  end
end
```

License
-------

MIT
