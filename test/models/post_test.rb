require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @post = @user.posts.build(title: 'Test Post', body: 'test post body 123 123...')
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user_id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "body content should be present" do
    @post.body = "    "
    assert_not @post.valid?
  end

  test "body content should be at most 150 chars" do
    @post.body = "?" * 151
    assert_not @post.valid?
  end

  test "order should be by created_at DESC" do
    assert_equal posts(:most_recent), Post.first
  end
end
