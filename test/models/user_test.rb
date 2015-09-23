require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should validate email" do
    user = User.new(name: 'test', email: 'test@test.com', password: 'test', password_confirmation: 'test')
    assert user.valid?
  end

  test "should not validate email" do
    user = User.new(name: 'test', email: 'test@gmail', password: 'test', password_confirmation: 'test')
    assert_not user.valid?
    assert_equal ["O email inserido não possui um formato válido."], user.errors.messages[:email]
  end
end
