require 'biq/version'
require 'biq/client'
require 'biq/result_parser'
require 'biq/company'
require 'biq/person'
require 'biq/key_figures'
require 'biq/address'

# Biq Client module
# Used to extract data from BiQ
module Biq
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.client
    @client ||= Client.new
  end

  # Configuration class for BiQ
  # Usage:
  # Biq.configure do |biq|
  #   biq.api_key = 'foobar'
  # end
  class Configuration
    attr_accessor :api_key

    def initialize
    end
  end
end
