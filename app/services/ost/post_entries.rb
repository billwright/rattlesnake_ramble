module OST
  class PostEntries
    def self.perform(args)
      post_entries = new(args)
      post_entries.perform
      post_entries.response
    end

    attr_reader :response

    def initialize(args)
      @race_edition = args[:race_edition]
      @ost_event_id = args[:ost_event_id]
      @token = args[:token]
    end

    def perform
      self.response = RestClient.post(import_url, translated_effort_data, {Authorization: "Bearer #{token}"})
    rescue RestClient::ExceptionWithResponse => e
      self.response = e.response
    end

    def response_body
      JSON.parse(response.body)
    end

    def errors
      response_body['errors']
    end

    private

    attr_reader :race_edition, :ost_event_id, :token
    attr_writer :response

    def import_url
      ENV['OST_URL'] + import_endpoint
    end

    def import_endpoint
      OST::Constants::IMPORT_ENDPOINT.sub(':id', ost_event_id)
    end

    def translated_effort_data
      {data: translated_race_entries, data_format: :jsonapi_batch, unique_key: [:first_name, :last_name, :birthdate]}
    end

    def translated_race_entries
      race_edition.race_entries.map { |race_entry| OST::TranslateRaceEntry.perform(race_entry) }
    end
  end
end
