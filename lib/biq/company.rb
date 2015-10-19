module Biq
  class Company
    FIELDS = [
      :type, :id, :name, :entity_id, :status, :cvr,
      :website, :email, :phone, :fiscal_year_starts_on,
      :fiscal_year_ends_on, :capital_status_amount,
      :capital_status_currency, :signatories,
      :last_financial_report_delivered_on, :fax,
      :employees, :bank, :stock_exchange, :owner_value_sum,
      :old_min_employees, :old_max_employees, :protected_from_advertising,
      :last_article_of_association_found_on
    ]

    attr_reader(*FIELDS)

    attr_reader :key_figures, :address, :client, :search_data, :company_data

    def initialize(company_data, client, search_data)
      @client = client
      @search_data = search_data
      @company_data = company_data
      FIELDS.each do |fname|
        instance_variable_set("@#{fname}".to_sym, company_data[fname.to_s])
      end
      set_address
      set_key_figures
    end

    def search_person
      (search_data['excerpt'].split(',').last || '').strip
    end

    def founded_date
      address_history.last.created_at || address_history.last.ended_on
    end

    def address_history
      @addresses ||= client.find_company_addresses(entity_id)
    end

    def trades
      return nil unless embedded?
      embedded['trades'].map { |trade| trade['name'] }
    end

    def embedded?
      company_data.key?('_embedded')
    end

    def embedded
      @embedded ||= company_data['_embedded']
    end

    private

    def set_key_figures
      return unless embedded?
      return unless embedded.key?('current_key_figures')
      @key_figures = KeyFigures.new(embedded['current_key_figures'])
    end

    def set_address
      return unless embedded?
      return unless embedded.key?('current_address')
      @address = Address.new(embedded['current_address'], client)
    end
  end
end
