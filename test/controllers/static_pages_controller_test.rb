require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @base_title = 'Learning Ruby'
  end

  test "should get root" do
    get root_url
    assert_response :success
    assert_select "title", @base_title
  end

  test "should get home" do
    get home_url
    assert_response :success
    assert_select "title", @base_title
  end

  test "should get timer" do
    get timey_url
    assert_response :success
    assert_select "title", "Timer | #{@base_title}"
  end
end
