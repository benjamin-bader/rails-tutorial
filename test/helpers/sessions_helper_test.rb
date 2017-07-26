require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  include SessionsHelper

  def setup
    @user = users(:tester)
  end

  test "log in stashes the user's ID in the session" do
    assert_nil session[:user_id]

    log_in(@user)

    assert_same session[:user_id], users(:tester).id
  end

  test "current_user looks up the user whose ID is stored in the session" do
    session[:user_id] = @user.id

    assert_equal @user, current_user
  end

  test "current_user returns nil if the user cannot be found in the database" do
    session[:user_id] = 56

    assert_nil current_user
  end

  test "logged_in? is true if current_user is not nil" do
    log_in(@user)

    assert is_logged_in?
  end

  test "logged_in? is false if current_user is nil" do
    assert_not is_logged_in?
  end

  test 'log_out deletes the :user_id session param' do
    log_in(@user)

    log_out

    assert_not_includes session, :user_id
  end

  test 'log_out clears the current user' do
    log_in(@user)
    assert_not_nil current_user

    log_out

    assert_nil current_user
  end

  test 'current_user returns the correct user when the session is nil' do
    remember(@user)

    assert_equal @user, current_user
    assert is_logged_in?
  end

  test 'current_user returns nil when the remember digest is wrong' do
    remember(@user)
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end
