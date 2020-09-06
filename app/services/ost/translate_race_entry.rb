module OST
  class TranslateRaceEntry
    TRANSLATION_KEY = {first_name: {racer: :first_name},
                       last_name: {racer: :last_name},
                       gender: {racer: :gender},
                       birthdate: {racer: :birth_date},
                       email: {racer: :email},
                       city: {racer: :city},
                       state_code: {racer: :state},
                       bib_number: :bib_number,
                       scheduled_start_time: :scheduled_start_time}

    def self.perform(race_entry)
      new(race_entry).perform
    end

    def initialize(race_entry)
      @race_entry = race_entry
    end

    def perform
      hash = {type: 'efforts', attributes: translate_attributes}
      hash[:attributes][:scheduled_start_time] ||= default_start_time

      hash
    end

    private

    attr_reader :race_entry
    delegate :race_edition, :racer, to: :race_entry
    delegate :default_start_time_male, :default_start_time_female, to: :race_edition

    def translate_attributes
      TRANSLATION_KEY.map { |ost_attribute, rr_attribute| [ost_attribute, race_entry_value(rr_attribute)] }.to_h
    end

    def race_entry_value(attribute)
      if attribute.is_a?(Symbol)
        race_entry.send(attribute)
      else
        race_entry.send(attribute.keys.first).send(attribute.values.first)
      end
    end

    def default_start_time
      racer.male? ? default_start_time_male : default_start_time_female
    end
  end
end
