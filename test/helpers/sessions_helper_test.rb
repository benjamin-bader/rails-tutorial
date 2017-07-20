require 'test_helper'

class SessionHelperTest < ActionView::TestCase
  include SessionsHelper

  test "log in stashes the user's ID in the session" do
    assert_nil session[:user_id]

    log_in(users(:tester))

    assert_same session[:user_id], users(:tester).id
  end

  test "current_user looks up the user whose ID is stored in the session" do
    session[:user_id] = users(:tester).id

    assert_equal users(:tester), current_user
  end

  test "current_user returns nil if the user cannot be found in the database" do
    session[:user_id] = 56

    assert_nil current_user
  end

  test "logged_in? is true if current_user is not nil" do
    log_in(users(:tester))

    assert logged_in?
  end

  test "logged_in? is false if current_user is nil" do
    assert_not logged_in?
  end

  test 'log_out deletes the :user_id session param' do
    log_in(users(:tester))

    log_out

    assert_not_includes session, :user_id
  end

  test 'log_out clears the current user' do
    log_in(users(:tester))
    assert_not_nil current_user

    log_out

    assert_nil current_user
  end
end
