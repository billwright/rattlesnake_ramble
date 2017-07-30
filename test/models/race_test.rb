require 'test_helper'

class RaceTest < ActiveSupport::TestCase
  
  test 'race is valid' do
    race = Race.new(name: "Rattlesnake Ramble Even-Year Course")
    assert race.valid?
  end
  
  test 'race requires a name' do
    race = Race.new()
    assert_not race.valid?
  end
  
  test 'race requires a descriptive name' do
    race = Race.new(name: "RREY")
    assert_not race.valid?
  end
  
end