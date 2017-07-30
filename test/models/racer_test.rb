require 'test_helper'

class RacerTest < ActiveSupport::TestCase
  
  test "racer should be valid" do
    racer = Racer.new(first_name: "Bill", last_name: "Wright", email: "bill@wwwright.com", gender: "Male", birth_date: Date.new())
    assert racer.valid?
  end
  
  test "racer first_name is required" do
    racer = Racer.new(first_name: "", last_name: "Wright", email: "bill@wwwright.com", gender: "Male", birth_date: Date.new())
    assert_not racer.valid?
  end
  
  test "racer last_name is required" do
    racer = Racer.new(first_name: "Bill", last_name: "", email: "bill@wwwright.com", gender: "Male", birth_date: Date.new())
    assert_not racer.valid?
  end
  
  test "racer email is required" do
    racer = Racer.new(first_name: "Bill", last_name: "Wright", email: "", gender: "Male", birth_date: Date.new())
    assert_not racer.valid?
  end
  
  test "racer gender is required" do
    racer = Racer.new(first_name: "Bill", last_name: "", email: "bill@wwwright.com", gender: "", birth_date: Date.new())
    assert_not racer.valid?
  end
  
  test "racer birth_date is required" do
    racer = Racer.new(first_name: "Bill", last_name: "", email: "bill@wwwright.com", gender: "Male", birth_date: nil)
    assert_not racer.valid?
  end
end
