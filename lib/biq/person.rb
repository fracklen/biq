module Biq
  class Person
    FIELDS = [
      :type, :id, :name, :entity_id
    ]

    attr_reader *FIELDS
    attr_reader :client, :address

    def initialize(person_data, client)
      @client = client
      FIELDS.each do |fname|
        instance_variable_set("@#{fname}".to_sym, address_data[fname.to_s])
      end
      if person_data.has_key?('_embedded')
        if person_data.has_key?('current_address')
          @address = Address.new(person_data['current_address'])
        end
      end
    end
  end
end
