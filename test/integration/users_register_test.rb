require 'test_helper'

class UsersRegisterTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid registration info" do
    get register_path

    assert_select "form[action='#{register_path}']"

    assert_no_difference 'User.count' do
      post register_path, params: {
        user: {
          name: "",
          email: "invalid@google",
          password: "foo",
          password_confirmation: "bar"
        }
      }
    end

    assert_template 'users/new'
    assert_select '#errors ul > li', count: 4
  end

  test "successful registration with account activation" do
    get register_path

    assert_select "form[action='#{register_path}']"

    assert_difference 'User.count', 1 do
      post register_path, params: {
        user: {
          name: "Test Acc",
          email: "test@google.com",
          password: "12345678",
          password_confirmation: "12345678"
        }
      }
    end

    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?

    # Try to login before activation
    log_in_as(user)
    assert_not is_logged_in?

    # Invalid activation token
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?

    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: "xyz@yahoo")
    assert_not is_logged_in?

    # Valid activation link
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?

    follow_redirect!
    assert_template 'users/show'
    assert_not flash[:danger]
    assert is_logged_in?
  end
end
