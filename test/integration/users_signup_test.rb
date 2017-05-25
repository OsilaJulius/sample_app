require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      assert_select 'form[action=?]', "/signup"
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div[id=?]', "error_explanation"
    assert_select 'div[class=?]', "field_with_errors"
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Wakakao Panda",
                                         email: "wakakao@Panda.org",
                                         password:              "bamboo",
                                         password_confirmation: "bamboo" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
