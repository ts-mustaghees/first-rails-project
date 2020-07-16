require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { title: 'New Title', body: 'Lorem Ipsum...' } }
    end

    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Post.count', -1 do
      delete post_path(@post)
    end
    assert_redirected_to login_url
  end
end
