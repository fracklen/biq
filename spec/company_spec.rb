require 'spec_helper'

describe Biq::Company do
  let(:client) { Biq::Client.new }
  let(:company) do
    VCR.use_cassette('lokalebasen_search') do
      client.search('Lokalebasen A/S').first
    end
  end

  it 'finds the right company' do
    expect(company.cvr).to eq '31627877'
  end

  it 'has access to the search excerpt' do
    expect(company.search_person).to eq 'direktør: Jakob Dalhoff-Nielsen'
  end

  it 'has key figures' do
    expect(company.key_figures).not_to be_nil
  end

  it 'has an address' do
    expect(company.address).not_to be_nil
  end

  context 'key figures' do
    let(:key_figures) { company.key_figures }

    it 'has a year' do
      expect(key_figures.year).to eq '2014'
    end

    it 'has liquid funds' do
      expect(key_figures.liquid_funds).to eq 7000
    end
  end

  context 'address' do
    let(:address) { company.address }

    it 'has a postal number' do
      expect(address.postnummer).to eq 2100
    end

    it 'has a city' do
      expect(address.city).to eq 'København Ø'
    end
  end
end
