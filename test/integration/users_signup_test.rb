require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  include SessionsHelper

  test "invalid signup information" do
    get signup_path

    assert_select 'form[action="/signup"]'

    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
                                         email: 'user@invalid',
                                         password: 'foo',
                                         password_confirmation: 'bar'}}
    end
    assert_template 'users/new'

    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "successful signup" do
    get signup_path

    assert_select 'form[action="/signup"]'

    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'Test User',
                                         email: 'test@user.com',
                                         password: '6Chars',
                                         password_confirmation: '6Chars'}}
    end

    follow_redirect!

    assert_template 'users/show'

    # Make sure the flash shows up!
    assert_not flash.empty?

    assert logged_in?
  end
end
