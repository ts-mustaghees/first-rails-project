require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'login with invalid info' do
    get new_user_session_path
    assert_template 'sessions/new'

    post user_session_path, params: {
      session: { email: '', password: '' }
    }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'login with valid info followed by logout' do
    get new_user_session_path

    post user_session_path, params: {
      session: { email: @user.email, password: 'password' }
    }

    #assert user_signed_in?
    # assert_redirected_to @user
    # follow_redirect!
    # assert_template 'users/show'
    assert_template 'static_pages/home'
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", user_path(@user)

    # logout now
    delete user_session_path
    assert_not user_signed_in?
    assert_redirected_to new_user_session_path

    # simulate user logging out from another window
    delete user_session_path
    follow_redirect!
    assert_template 'sessions/new'
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    assert_select "a[href=?]", login_path
  end

  # test "login with remembering" do
  #   sign_in @user, remember_me: '1'
  #   assert @user.remember_created_at?
  #   assert_not_empty cookies['remember_token']
  #   assert_equal cookies['remember_token'], assigns(:user).remember_token
  # end

  # test "login without remembering" do
  #   # login to set cookie
  #   sign_in @user, remember_me: '1'

  #   #login again to delete cookie
  #   sign_in @user, remember_me: '0'

  #   assert_empty cookies['remember_token']
  # end
end
