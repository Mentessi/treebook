require 'test_helper'

class UserTest < ActiveSupport::TestCase

	should have_many(:user_friendships)
	should have_many(:friends)

	test "a user should enter a first name" do 
		user = User.new
		assert !user.save
		assert !user.errors[:first_name].empty?
	end

	test "a user should enter a last name" do 
		user = User.new
		assert !user.save
		assert !user.errors[:last_name].empty?
	end

	test "a user should enter a profile name" do 
		user = User.new
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have a unique profile name" do 
		user = User.new
		user.profile_name = users(:Michael).profile_name
		assert !user.save	
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have profile name without spaces" do 
		user = User.new(first_name: "Michael", last_name: "Mentessi", email: "mentessi@gmail.com")
		user.password = user.password_confirmation = "passwords99"
		user.profile_name = "My profile with spaces"

		assert !user.save
		assert !user.errors[:profile_name].empty?
		assert user.errors[:profile_name].include?("Must be formatted correctly.")
	end

	test "that a correctly formatted profile name works" do 
		user = User.new(first_name: "Michael", last_name: "Mentessi", email: "mentessi@gmail.com")
		user.password = user.password_confirmation = "passwords99"
		user.profile_name = "michael_mentessi1"
		assert user.valid?
	end


	test "that no error is raised when trying to get to a users friend" do 
		assert_nothing_raised do
			users(:Michael).friends
		end
	end

	test "that creating friendships ona user works" do 
		users(:Michael).friends << users(:Neil)
		users(:Michael).reload
		assert users(:Michael).friends.include?(users(:Neil))
	end

end
