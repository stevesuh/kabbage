require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_template :home
  end

  test "should get search" do
    get :search, {'q' => 'Bieber'}
    assert_response :success
    assert_template :search
  end

  test "should return empty search for blank query" do
    get :search, {'q' => ''}
    assert_response :success
    assert_template :search
  end

end
