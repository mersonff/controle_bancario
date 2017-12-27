require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(email: "emerson@example.com", password: "password", password_confirmation: "password")
	end

	test "user should be valid" do
		assert @user.valid?
	end

	test "user email should be valid" do
		@user.email = ""
		assert_not @user.valid?
	end

	test "user email shouldn't be to long" do
		@user.email = "a" * 245 +"@example.com"
		assert_not @user.valid?
	end

	test "user email should be correct format" do
		valid_emails = %w[user@example.com emerson@gmail.com e.first@yahoo.ca john+doe@co.uk.org]
		valid_emails.each do |valids|
			@user.email = valids
			assert @user.valid?, "#{valids.inspect} should be valid"
		end
	end

	test "should reject invalid emails" do
		invalid_emails = %w[user@example emerson@gmail,com e.first@yahoo. john@co+foo.org]
		invalid_emails.each do |invalids|
			@user.email = invalids
			assert_not @user.valid?, "#{invalids.inspect} should be valid"
		end
	end

	test "user email should be unique and case insensitive" do
		duplicated_user = @user.dup
		duplicated_user.email = @user.email.upcase
		@user.save
		assert_not duplicated_user.valid?
	end

	test "user email should be lowercase before hitting db" do
		mixed_email = "EmERSon@exAMple.COM"
		@user.email = mixed_email
		@user.save
		assert_equal mixed_email.downcase, @user.reload.email
	end

	test "password should be present" do
		@user.password = @user.password_confirmation = " "
		assert_not @user.valid?
	end

	test "password should be a atleast 5 character" do
		@user.password = @user.password_confirmation = "x" * 4
		assert_not @user.valid?
	end

end