module Biq
  class ResultParser
    class << self
      def parse(data, client)
        new(data, client).parse
      end
    end

    attr_reader :data, :client

    CLOSED_EXCERPTS = %w(opløst konkurs likvideret)

    def initialize(data, client)
      @data = data
      @client = client
    end

    def parse
      return parse_embedded_results if embedded_results?
      return nil
    end

    def embedded_results?
      data.has_key?('_embedded') && data['_embedded'].has_key?('results')
    end

    def parse_embedded_results
      data['_embedded']['results'].map do |result|
        parse_result(result)
      end.compact
    end

    def parse_result(result)
      case result['type']
      when 'companies'
        parse_company(result)
      when 'people'
        parse_person(result)
      else
        nil
      end
    end

    def parse_company(company_data)
      return nil if CLOSED_EXCERPTS
        .any? { |ex| company_data['excerpt'].include?(ex) }

      Company.new(client.find_company(company_data['id']), client, company_data)
    end

    def parse_person(person_data)
      Person.new(client.find_person(person_data['id']), client)
    end

    def parse_addresses(addresses)
      addresses.map do |address|
        parse_address(address)
      end
    end

    def parse_address(address_data)
      Address.new(address_data, client)
    end
  end
end
