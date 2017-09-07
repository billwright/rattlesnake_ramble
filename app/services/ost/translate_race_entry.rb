module OST
  class TranslateRaceEntry

    TRANSLATION_KEY = {first_name: {racer: :first_name},
                       last_name: {racer: :last_name},
                       gender: {racer: :gender},
                       birthdate: {racer: :birth_date},
                       email: {racer: :email},
                       city: {racer: :city},
                       state_code: {racer: :state}}

    def self.perform(race_entry)
      new(race_entry).perform
    end

    def initialize(race_entry)
      @race_entry = race_entry
    end

    def perform
      TRANSLATION_KEY.map { |ost_attribute, rr_attribute| [ost_attribute, race_entry_value(rr_attribute)] }.to_h
    end

    private

    attr_reader :race_entry

    def race_entry_value(attribute)
      if attribute.is_a?(Symbol)
        race_entry.send(attribute)
      else
        race_entry.send(attribute.keys.first).send(attribute.values.first)
      end
    end
  end
end
