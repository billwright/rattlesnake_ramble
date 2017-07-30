class RaceEditionTest < ActiveSupport::TestCase
  
  test "race edition should have a valid race id" do
    race = Race.create(name: "My special race")
    race_edition = race.race_editions.build(date: "2017-09-09")
    
    assert race_edition.valid?
  end
  
end
