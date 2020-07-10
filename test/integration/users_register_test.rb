require 'test_helper'

class UsersRegisterTest < ActionDispatch::IntegrationTest
  test "invalid registration info" do
    get register_path

    assert_select "form[action='#{register_path}']"

    assert_no_difference 'User.count' do
      post users_path, params: {
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

  test "successful registration" do
    get register_path

    assert_select "form[action='#{register_path}']"

    assert_difference 'User.count' do
      post users_path, params: {
        user: {
          name: "Test Acc",
          email: "test@google.com",
          password: "12345678",
          password_confirmation: "12345678"
        }
      }
    end

    follow_redirect!
    assert_template 'users/show'
    assert_not flash[:danger]
  end
end
