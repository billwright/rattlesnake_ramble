require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    # TODO: what is this welcome_index_url? This text only appears in this one spot in the project
    # What is GET loading? Is this some Rails "magic"? In the routes.rb file we have a line like this:
    #     GET 'welcome/index'
    # Why wouldn't we just do that here, if that's what we're doing?
    get welcome_index_url
    assert_response :success
  end

end
