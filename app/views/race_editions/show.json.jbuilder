json.(
  @race_edition,
    :date,
    :default_start_time_male,
    :default_start_time_female,
    :entry_fee,
    :created_at,
    :updated_at,
)

json.race do
  json.name @race_edition.race.name
end

json.race_entries @race_edition.race_entries do |race_entry|
  default_scheduled_start_time =
    race_entry.female? ? @race_edition.default_start_time_female : @race_edition.default_start_time_male

  json.bib_number race_entry.bib_number
  json.scheduled_start_time race_entry.scheduled_start_time || default_scheduled_start_time
  json.racer do
    json.first_name race_entry.racer.first_name
    json.last_name race_entry.racer.last_name
    json.gender race_entry.racer.gender
    json.birth_date race_entry.racer.birth_date
    json.email race_entry.racer.email
    json.city race_entry.racer.city
    json.state race_entry.racer.state
  end
end
