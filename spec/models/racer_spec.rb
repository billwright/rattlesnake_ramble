# frozen_string_literal: true

require 'rails_helper'

# t.string "first_name"
# t.string "last_name"
# t.string "gender"
# t.string "email"
# t.string "city"
# t.string "state"
# t.date "birth_date"

RSpec.describe Racer, type: :model do
  include ActiveSupport::Testing::TimeHelpers
  it { is_expected.to strip_attribute(:first_name).collapse_spaces }
  it { is_expected.to strip_attribute(:last_name).collapse_spaces }
  it { is_expected.to strip_attribute(:city).collapse_spaces }
  it { is_expected.to strip_attribute(:state).collapse_spaces }
  it { is_expected.to strip_attribute(:email).collapse_spaces }

  describe '#initialize' do
    it 'is valid when created with first_name, last_name, gender, email, and birth_date' do
      racer = build_stubbed(:racer)
      expect(racer.first_name).to be_present
      expect(racer.last_name).to be_present
      expect(racer.gender).to be_present
      expect(racer.email).to be_present
      expect(racer.birth_date).to be_present
      expect(racer).to be_valid
    end

    it 'is invalid when created without a first_name' do
      racer = build_stubbed(:racer, first_name: '')
      expect(racer).to be_invalid
      expect(racer.errors.full_messages).to include("First name can't be blank")
    end

    it 'is invalid when created without a last_name' do
      racer = build_stubbed(:racer, last_name: '')
      expect(racer).to be_invalid
      expect(racer.errors.full_messages).to include("Last name can't be blank")
    end

    it 'is invalid when created without a gender' do
      racer = build_stubbed(:racer, gender: '')
      expect(racer).to be_invalid
      expect(racer.errors.full_messages).to include("Gender can't be blank")
    end

    it 'is invalid when created without an email' do
      racer = build_stubbed(:racer, email: '')
      expect(racer).to be_invalid
      expect(racer.errors.full_messages).to include("Email can't be blank")
    end

    it 'is invalid when created without a birth_date' do
      racer = build_stubbed(:racer, birth_date: '')
      expect(racer).to be_invalid
      expect(racer.errors.full_messages).to include("Birth date can't be blank")
    end

    it 'permits valid email addresses' do
      good_emails = %w(Sheri_Wright@oracle.com bill@wwwright.com Sheri_Wright@oracle.com)

      good_emails.each do |email|
        racer = build_stubbed(:racer, email: email)
        expect(racer).to be_valid
      end
    end

    it 'rejects invalid email addresses' do
      bad_emails = %w(user@example,com user_at_example.com foo@oracle)

      bad_emails.each do |email|
        racer = build_stubbed(:racer, email: email)
        expect(racer).to be_invalid
        expect(racer.errors.full_messages).to include('Email is invalid')
      end
    end
  end

  describe 'before_save callbacks' do
    subject { build(:racer, email: email, birth_date: birth_date) }
    let(:email) { 'mail@example.com' }
    let(:birth_date) { '1/1/1970' }

    context 'when email contains uppercase characters' do
      let(:email) { 'Bill.Wright@Example.com' }

      it 'changes email to lowercase' do
        subject.run_callbacks :save
        expect(subject.email).to eq('bill.wright@example.com')
      end
    end

    context 'when email is nil' do
      let(:email) { nil }

      it 'does not raise an error and makes no changes' do
        expect { subject.run_callbacks :save }.not_to raise_error
        expect(subject.email).to be_nil
      end
    end

    context 'when birth_date year is provided as four digits' do
      let(:birth_date) { '1/1/1990' }

      it 'makes no change' do
        expect(subject.birth_date.year).to eq(1990)
        subject.run_callbacks :save
        expect(subject.birth_date.year).to eq(1990)
      end
    end

    context 'when birth_date year is provided as two digits that are between 0 and the current two-digit year' do
      let(:birth_date) { '1/1/08' }

      it 'adds 2000 to the year' do
        expect(subject.birth_date.year).to eq(8)
        subject.run_callbacks :save
        expect(subject.birth_date.year).to eq(2008)
      end
    end

    context 'when birth_date year is provided as two digits that are between the current two-digit year and 99' do
      let(:birth_date) { '1/1/88' }

      it 'adds 1900 to the year' do
        expect(subject.birth_date.year).to eq(88)
        subject.run_callbacks :save
        expect(subject.birth_date.year).to eq(1988)
      end
    end

    context 'when birth_date is nil' do
      let(:birth_date) { nil }

      it 'does not raise an error and makes no changes' do
        expect { subject.run_callbacks :save }.not_to raise_error
        expect(subject.birth_date).to be_nil
      end
    end
  end

  describe '#name' do
    it 'returns a concatenated first_name and last_name' do
      racer = build_stubbed(:racer, first_name: 'Bill', last_name: 'Wright')
      expect(racer.name).to eq('Bill Wright')
    end
  end

  describe '#current_age' do
    it 'returns the current age in years based on the birth_date' do
      racer = build_stubbed(:racer, birth_date: DateTime.parse('2000-07-31'))
      travel_to Time.zone.local(2017, 8, 1)
      expect(racer.current_age).to eq(17)
    end

    it 'returns the correct age when current time is an earlier date within the year than the birth_date' do
      racer = build_stubbed(:racer, birth_date: DateTime.parse('2000-07-31'))
      travel_to Time.zone.local(2017, 7, 30)
      expect(racer.current_age).to eq(16)
    end

    it 'returns the correct age when current time is on the same day as the birth_date' do
      racer = build_stubbed(:racer, birth_date: DateTime.parse('2000-07-31'))
      travel_to Time.zone.local(2017, 7, 31)
      expect(racer.current_age).to eq(17)
    end
  end

  describe '#home_location' do
    it 'returns the city and state when both are present' do
      racer = build_stubbed(:racer, city: 'Boulder', state: 'Colorado')
      expect(racer.home_location).to eq('Boulder, Colorado')
    end

    it 'returns the city only when no state is present' do
      racer = build_stubbed(:racer, city: 'Boulder', state: '')
      expect(racer.home_location).to eq('Boulder')
    end

    it 'returns the state only when no city is present' do
      racer = build_stubbed(:racer, city: '', state: 'Colorado')
      expect(racer.home_location).to eq('Colorado')
    end

    it 'functions the same when city is nil' do
      racer = build_stubbed(:racer, city: nil, state: 'Colorado')
      expect(racer.home_location).to eq('Colorado')
    end

    it 'functions the same when state is nil' do
      racer = build_stubbed(:racer, city: 'Boulder', state: nil)
      expect(racer.home_location).to eq('Boulder')
    end
  end
end
