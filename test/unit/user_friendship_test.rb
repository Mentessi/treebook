require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase

	should belong_to(:user)

	should belong_to(:friend)

	test "that creating a friendship works" do 
		assert_nothing_raised do 
			UserFriendship.create user: users(:Michael), friend: users(:Neil)
		end
	end

	test "that creating a friendship based on user id and friend id works" do
		UserFriendship.create user_id: users(:Michael).id, friend_id: users(:Neil).id
		assert users(:Michael).friends.include?(users(:Neil))
	end

end
