require 'faraday'
require 'active_support'
require 'active_support/core_ext'

module Biq
  class Client
    API_URL = 'https://www.biq.dk/api/v1/'

    def search(company_name)
      parse(search_result(company_name))
    end

    def find_company(id)
      JSON.parse(get("companies/#{id}").body)
    end

    def find_address(id)
      JSON.parse(get("addresses/#{id}").body)
    end

    def find_person(id)
      JSON.parse(get("people/#{id}").body)
    end

    def find_company_addresses(id)
      parse_addresses(JSON.parse(get("companies/#{id}/addresses").body))
    end

    private

    def parse(result)
      ResultParser.parse(result, self)
    end

    def parse_addresses(addresses)
      ResultParser.new(nil, self).parse_addresses(
        addresses['_embedded']['addresses']
      )
    end

    def search_result(company_name)
      JSON.parse(perform_search(company_name).body)
    end

    def perform_search(company_name)
      get("companies/search", name: company_name)
    end

    def get(resource, options = {})
      connection.get do |req|
        req.url "/api/v1/#{resource}?#{params(options).to_query}"
        req.headers['Accept'] = '*/*'
        req.headers['Host'] = 'www.biq.dk'
      end
    end

    def params(options)
      options.merge(key: api_key)
    end

    def connection
      @connection ||= Faraday.new(url: API_URL) do |c|
        c.use Faraday::Request::UrlEncoded
        c.use Faraday::Adapter::Excon
        c.use Faraday::Response::RaiseError
      end
    end

    def api_key
      Biq.configuration.api_key
    end
  end
end
