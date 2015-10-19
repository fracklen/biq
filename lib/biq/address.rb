module Biq
  class Address
    FIELDS = [
      :city, :country, :created_at, :entity_id,
      :floor, :house_number, :house_number_from,
      :housenumber_parseable, :id, :latitude, :longitude,
      :municipality, :municipal_code, :normalized_street_name,
      :postnummer, :postby, :street_name, :street_code,
      :streetname_parseable, :updated_at, :verified_at, :ended_on
    ]

    attr_reader(*FIELDS)
    attr_reader :client

    def initialize(address_data, client)
      @client = client
      FIELDS.each do |fname|
        instance_variable_set("@#{fname}".to_sym, address_data[fname.to_s])
      end
    end
  end
end
