require 'spec_helper'

describe Biq::Client do
  let(:client) { Biq::Client.new }

  it 'can find 1 Lokalebasen A/S' do
    VCR.use_cassette('lokalebasen_search') do
      expect(client.search('Lokalebasen A/S').size).to eq 1
    end
  end

  it 'finds Lokalebasen A/S' do
    VCR.use_cassette('lokalebasen_search') do
      expect(client.search('Lokalebasen A/S').first.name).to eq "LOKALEBASEN.DK A/S"
    end
  end
end
