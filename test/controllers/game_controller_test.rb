require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  test "should get home and return all in progress or upcoming games" do
    get :home
    assert_response :success
    games = assigns(:games)
    binding.pry
  end

end
