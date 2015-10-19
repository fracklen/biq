module Biq
  class Person
    FIELDS = [
      :type, :id, :name, :entity_id
    ]

    attr_reader(*FIELDS)
    attr_reader :client, :address, :person_data

    def initialize(person_data, client)
      @client = client
      @person_data = person_data
      FIELDS.each do |fname|
        instance_variable_set("@#{fname}".to_sym, address_data[fname.to_s])
      end
      set_address
    end

    private

    def embedded?
      person_data.key?('_embedded')
    end

    def embedded
      @embedded ||= person_data['_embedded']
    end

    def set_address
      return unless embedded?
      return unless embedded.key?('current_address')
      @address = Address.new(embedded['current_address'], client)
    end
  end
end
