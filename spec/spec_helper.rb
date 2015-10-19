$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'biq'
require 'vcr'

VCR.configure do |vcr|
  vcr.cassette_library_dir = 'vcr/cassettes'
  vcr.hook_into :excon
  vcr.configure_rspec_metadata!
  vcr.default_cassette_options = { :record => :new_episodes, erb: true }
end

Biq.configure do |biq|
  biq.api_key = ENV['BIQ_API_KEY']
end
