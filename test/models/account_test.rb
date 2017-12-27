require 'test_helper'

class AccountTest < ActiveSupport::TestCase

	def setup
		@agency = Agency.create!(number: 1, address: "Rua JK, 151, Centro")
		@account = Account.new(account_number: 1, limit: 1000.00, balance: 300, agency: @agency)
	end

	test "account should be valid" do
		assert @account.valid?
	end

	test "account should have a number" do
		@account.account_number = nil
		assert_not @account.valid?
	end

	test "account should have a limit" do
		@account.limit = nil
		assert_not @account.valid?
	end

	test "account should have a balance" do
		@account.balance = nil
		assert_not @account.valid?
	end

	test "account number should be unique" do
		duplicated_account = @account.dup
		@account.save
		assert_not duplicated_account.valid?
	end
end