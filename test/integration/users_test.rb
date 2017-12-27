require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  def setup
		@user = User.create!(email: "emerson@example.com", password: "password", password_confirmation: "password")
	end

	test "reject invalid login" do
		get login_path
		assert_template 'sessions/new'
		post login_path, params: { session: {email: "", password: "" } }
		assert_template 'sessions/new'
		assert_not flash.empty?
		assert_select "a[href=?]", login_path
		assert_select "a[href=?]", logout_path, count: 0
		get root_path
		assert flash.empty?
	end

	test "valid login and begin session" do
		get login_path
		assert_template 'sessions/new'
		post login_path, params: { session: {email: @user.email, password: @user.password } }
		assert_redirected_to @user
		follow_redirect!
		assert_template 'users/show'
		assert_not flash.empty?
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", logout_path
	end

	test "reject an invalid signup" do
		get signup_path
		assert_no_difference "User.count" do
			post users_path, params: { user: { email: " ", password: "password", password_confirmation: " "} }
		end
		assert_template 'users/new'
		assert_select 'h2.error-title'
		assert_select 'div.error-body'
	end

	test "accept valid signup" do
		get signup_path
		assert_difference "User.count", 1 do
			post users_path, params: { user: { email: "emerson2@example.com", password: "password", 
				password_confirmation: "password" } }
		end
		follow_redirect!
		assert_template 'users/show'
		assert_not flash.empty?
	end

	test "users listing" do
		get users_path
		assert_template 'users/index'
		assert_select "a[href=?]", edit_user_path(@user), text: "Editar"
	end

	test "user delete" do
		sign_in_as(@user, "password")
		get users_path
		assert_template 'users/index'
		assert_difference 'User.count', -1 do
			delete user_path(@user)
		end
		assert_redirected_to users_path
		assert_not flash.empty?
	end


end
