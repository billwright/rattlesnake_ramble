# frozen_string_literal: true

require "rails_helper"

RSpec.describe RaceEditionsController do
  render_views

  before { FactoryBot.create(:user, email: "other@example.com", password: "password") }

  describe "#index" do
    let(:make_request) { get :index, format: :json, params: params }
    let(:params) { {} }

    before { FactoryBot.create_list(:race_edition, 2) }

    context "with no credentials" do
      it "returns 401" do
        make_request
        expect(response.status).to eq(401)
      end
    end

    context "with valid credentials" do
      let(:params) do
        {
          user: {
            email: "other@example.com",
            password: "password"
          }
        }
      end

      it "returns a successful response" do
        make_request
        expect(response.status).to eq(200)
      end

      it "returns json with all race editions" do
        make_request
        parsed_body = JSON.parse(response.body)

        expect(parsed_body).to be_a Array
        expect(parsed_body.count).to eq(2)
        expect(parsed_body.first.keys).to match_array(%w(id date race_name))
      end
    end
  end

  describe "#show" do
    let(:make_request) { get :show, format: :json, params: params }
    let(:params) do
      {
        id: race_edition.id,
      }
    end

    let!(:race_edition) do
      FactoryBot.create(
        :race_edition,
        default_start_time_male: default_start_time_male,
        default_start_time_female: default_start_time_female,
      )
    end

    let(:default_start_time_male) { "2023-09-16 08:00:00".in_time_zone }
    let(:default_start_time_female) { "2023-09-16 08:15:00".in_time_zone }

    let!(:race_entries) do
      [
        FactoryBot.create(:race_entry, race_edition: race_edition, racer: male_racer),
        FactoryBot.create(:race_entry, race_edition: race_edition, racer: female_racer),
      ]
    end

    let(:male_racer) { FactoryBot.create(:racer, :male) }
    let(:female_racer) { FactoryBot.create(:racer, :female) }

    context "with no credentials" do
      it "returns 401" do
        make_request
        expect(response.status).to eq(401)
      end
    end

    context "with valid credentials" do
      let(:params) do
        {
          id: race_edition.id,
          user: {
            email: "other@example.com",
            password: "password",
          }
        }
      end

      let(:expected_race_edition_keys) do
        %w[created_at date default_start_time_female default_start_time_male entry_fee id race race_entries updated_at]
      end

      let(:expected_race_entry_keys) do
        %w[bib_number scheduled_start_time racer]
      end

      it "returns the race edition" do
        make_request
        parsed_body = JSON.parse(response.body)

        expect(parsed_body).to be_a(Hash)
        expect(expected_race_edition_keys).to all be_in(parsed_body.keys)
      end

      it "returns an array of race entries" do
        make_request
        parsed_body = JSON.parse(response.body)

        race_entries = parsed_body["race_entries"]
        expect(race_entries).to be_a(Array)
        expect(race_entries.count).to eq(2)

        male_race_entry = race_entries.first
        expect(expected_race_entry_keys).to all be_in(male_race_entry.keys)
        expect(male_race_entry["scheduled_start_time"].in_time_zone).to eq(race_edition.default_start_time_male)

        female_race_entry = race_entries.second
        expect(expected_race_entry_keys).to all be_in(female_race_entry.keys)
        expect(female_race_entry["scheduled_start_time"].in_time_zone).to eq(race_edition.default_start_time_female)
      end
    end
  end
end
