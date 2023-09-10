json.array! RaceEdition.includes(:race).all.find_each do |race_edition|
  json.id race_edition.id
  json.date race_edition.date
  json.race_name race_edition.race.name
end
