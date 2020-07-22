require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:archer)
  end

  test "post interface" do
    sign_in @user
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'
    
    # Invalid submission
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { title: '', body: '' } }
    end
    assert_select 'div#errors'
    
    # Valid submission
    content = "This post really ties the room together"
    picture = fixture_file_upload('test/fixtures/user-profile-pic.png', 'image/png')
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { title: 'test', body: content, picture: picture } }
    end
    
    assert assigns(:post).picture?
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    
    # Delete post
    assert_select 'a', text: 'DELETE'
    first_post = @user.posts.paginate(page: 1).first
    assert_difference 'Post.count', -1 do
      delete post_path(first_post)
    end
    
    # Visit different user (no delete links)
    get user_path(users(:michael))
    assert_select 'a', text: 'DELETE', count: 0
  end
end
