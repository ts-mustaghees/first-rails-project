require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @base_title = "Learning Ruby"
  end

  test "should get index" do
    get posts_url
    assert_response :success
    assert_select "title", "Posts | #{@base_title}"
  end

  test "should get new" do
    get new_post_url
    assert_response :success
    assert_select "title", "New Post | #{@base_title}"
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
    assert_select "title", "#{@post.title} | #{@base_title}"
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
    assert_select "title", "Editing #{@post.title} | #{@base_title}"
  end
end
