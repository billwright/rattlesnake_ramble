# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RaceEditionPresenter do
  subject { RaceEditionPresenter.new(race_edition) }
  let(:race_edition) { build_stubbed(:race_edition, race: race) }
  let(:race) { build_stubbed(:race) }

  describe 'missing methods' do
    it 'passes missing methods through to the race_edition' do
      expect(subject.date).to eq(race_edition.date)
      expect(subject.name).to eq(race_edition.name)
    end
  end

  describe '#categories' do
    context 'when the race does not include "kids" in the name' do
      let(:race) { build_stubbed(:race, name: '2019 Ramble') }

      it 'uses the adult categories' do
        expect(subject.category_size_map.size).to eq(12)
        expect(subject.category_size_map.map(&:first)).to eq(['Under 20 Men', 'Under 20 Women', '20 to 29 Men', '20 to 29 Women', '30 to 39 Men', '30 to 39 Women', '40 to 49 Men', '40 to 49 Women', '50 to 59 Men', '50 to 59 Women', '60+ Men', '60+ Women'])
      end
    end

    context 'when the race includes "kids" in the name' do
      let(:race) { build_stubbed(:race, name: '2019 Ramble Kids') }

      it 'uses the kids categories' do
        expect(subject.category_size_map.size).to eq(2)
        expect(subject.category_size_map.map(&:first)).to eq(['Boys', 'Girls'])
      end
    end
  end
end
