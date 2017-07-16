require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
        name: "Example User",
        email: "user@example.com",
        password: 'foobar',
        password_confirmation: 'foobar')
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "x" * 201
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = 'x' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test "email validation accepts valid addresses" do
    valid_addresses = %w{user@example.com USER@foo.COM a_us-er@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn}
    valid_addresses.each do |addr|
      @user.email = addr
      assert @user.valid?, "#{addr} should be valid"
    end
  end

  test "email should be a valid email address" do
    invalid_addresses = %w{
      user@example,com user_att_foo.org user.name@example.
      foo@bar_baz.com foo@bar+baz.com foo@bar..com
    }
    invalid_addresses.each do |addr|
      @user.email = addr
      assert_not @user.valid?, "#{addr} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lowercase" do
    mixed_case_email = "FoO@eXaMpLe.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
end
