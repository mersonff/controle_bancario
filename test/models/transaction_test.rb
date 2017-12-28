require 'test_helper'

class TransactionTest < ActiveSupport::TestCase

	def setup
		@agency = Agency.create!(number: 001, address: "Rua JK 151, Centro")
		@account = Account.create!(account_number: 1, limit: 1000, balance: 300, agency: @agency)
		@user = User.create!(email: "emerson@example.com", password: "password", password_confirmation: "password")
		@transaction = Transaction.new(date: "27/12/2017", value: 1000, 
			type_of_transaction: "Depósito", account: @account, user: @user)
	end

	test "transaction should be valid" do
		assert @transaction.valid?
	end

	test "transaction should have a account" do
		@transaction.account = nil
		assert_not @transaction.valid?
	end

	test "transaction should have a date" do
		@transaction.date = ""
		assert_not @transaction.valid?
	end

	test "transaction should have a value" do
		@transaction.value = nil
		assert_not @transaction.valid?
	end

	test "transaction should have a type" do
		@transaction.type_of_transaction = ""
		assert_not @transaction.valid?
	end

	test "transaction should have a user" do
		@transaction.user = nil
		assert_not @transaction.valid?
	end


end