# Employer::Mongoid [![Build Status](https://travis-ci.org/mkremer/employer-mongoid.png)](https://travis-ci.org/mkremer/employer-mongoid)

NOTE: This code is still experimental

Mongoid backend for Employer

## Installation

Add this line to your application's Gemfile:

    gem 'employer-mongoid'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install employer-mongoid

## Usage

Ensure that your Employer configuration starts with something like the below:

```ruby
require "./config/environment.rb"
require "employer-mongoid"

pipeline_backend Employer::Mongoid::Pipeline.new
```

If you're not using Rails then require whatever sets up your application's
environment instead of config/environment.rb before requiring employer-mongoid. 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
