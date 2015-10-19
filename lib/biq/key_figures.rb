module Biq
  class KeyFigures
    FIELDS = [
      :id, :company_id, :created_at, :updated_at, :year,
      :annual_result, :annual_result_growth, :balance_sheet,
      :balance_sheet_growth, :depreciation_financial_statement,
      :financial_expenses, :financial_statement_enddate,
      :financial_statement_startdate, :fixed_assets, :gross_profit_margin,
      :gross_profit_margin_growth, :growth_factor, :liabilities_in_all,
      :liabilities_in_all_growth, :liquid_funds, :liquid_funds_growth,
      :report_model, :result_before_tax, :result_before_tax_growth,
      :short_term_debt, :short_term_debt_growth, :solvency_ratio,
      :total_equity, :total_equity_growth
    ]

    attr_reader *FIELDS

    def initialize(key_data)
      FIELDS.each do |fname|
        instance_variable_set("@#{fname}".to_sym, key_data[fname.to_s])
      end
    end
  end
end
