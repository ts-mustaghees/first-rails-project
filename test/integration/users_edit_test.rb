require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsuccessfull edit" do
    sign_in @user
  
    get edit_user_registration_path
    assert_template 'users/registrations/edit'

    patch user_registration_path, params: {
      user: { name: "", email: "foo@", password: "132", password_confirmation: "asdfg", current_password: 'password' }
    }

    assert_template 'users/registrations/edit'
    assert_select '#errors li', count: 4
  end

  test "successfull edit with friendly forwarding" do
    sign_in @user
    get edit_user_registration_path

    name = "Mark Zuckerberg"
    email = "mark@facebook.com"

    patch user_registration_path, params: {
      user: { name: name, email: email, password: '', password_confirmation: '', current_password: 'password' }
    }

    # TODO: an email is sent here, for email change verification

    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    #assert_equal email, @user.email
  end
end
