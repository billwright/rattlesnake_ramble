module OST
  class PostEntries
    def self.perform(args)
      new(args).perform
    end

    def initialize(args)
      @race_edition = args[:race_edition]
      @ost_event_id = args[:ost_event_id]
      @token = args[:token]
    end

    def perform
      RestClient.post(import_url, translated_effort_data, {Authorization: "Bearer #{token}"})
    end

    private

    attr_reader :race_edition, :ost_event_id, :token

    def import_url
      ENV['OST_URL'] + import_endpoint
    end

    def import_endpoint
      OST::Constants::IMPORT_ENDPOINT.sub(':id', ost_event_id)
    end

    def translated_effort_data
      {data: translated_race_entries, data_format: :jsonapi_batch, unique_key: [:first_name, :last_name, :birthdate]}.to_json
    end

    def translated_race_entries
      race_edition.race_entries.map { |race_entry| OST::TranslateRaceEntry.perform(race_entry) }
    end
  end
end