require 'test_helper'

class RacerTest < ActiveSupport::TestCase
  
  test "racer should be valid" do
    racer = Racer.new(first_name: "Bill", last_name: "Wright", email: "bill@wwwright.com", gender: "Male", birth_date: Time.now)
    assert racer.valid?, "#{racer.inspect} should be valid"
  end
  
  test "racer first_name is required" do
    racer = Racer.new(first_name: "", last_name: "Wright", email: "bill@wwwright.com", gender: "Male", birth_date: Time.now)
    assert_not racer.valid?, "#{racer.inspect} should be invalid"
  end
  
  test "racer last_name is required" do
    racer = Racer.new(first_name: "Bill", last_name: "", email: "bill@wwwright.com", gender: "Male", birth_date: Time.now)
    assert_not racer.valid?
  end
  
  test "racer email is required" do
    racer = Racer.new(first_name: "Bill", last_name: "Wright", email: "", gender: "Male", birth_date: Time.now)
    assert_not racer.valid?
  end
  
  test "racer gender is required" do
    racer = Racer.new(first_name: "Bill", last_name: "", email: "bill@wwwright.com", gender: "", birth_date: Time.now)
    assert_not racer.valid?
  end
  
  test "racer birth_date is required" do
    racer = Racer.new(first_name: "Bill", last_name: "", email: "bill@wwwright.com", gender: "Male", birth_date: nil)
    assert_not racer.valid?
  end
  
  # TODO: Can't get email validations to work. Don't know why. Regexs work in IRB. Might be differene in Rails 5
  #
  # test "racer email should be valid" do
  #   good_emails = ['Sheri_Wright@oracle.com', 'bill@wwwright.com', 'Sheri_Wright@oracle.com', ]

  #   good_emails.each do | currEmail |
  #     racer = Racer.new(first_name: "First", last_name: "Last", email: currEmail, gender: "Cis", birth_date:  Time.now)
  #     assert racer.valid?, "#{racer.email.inspect} should be valid"
  #   end
    
  #   bad_emails = ['user@example,com', 'user_at_example.com', 'foo@oracle']

  #   bad_emails.each do | currEmail |
  #     racer = Racer.new(first_name: "First", last_name: "Last", email: currEmail, gender: "Cis", birth_date:  Time.now)
  #     assert_not racer.valid?, "#{racer.email.inspect} should be invalid"
  #   end
  # end
  
end
