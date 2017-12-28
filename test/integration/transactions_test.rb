require 'test_helper'

class TransactionsTest < ActionDispatch::IntegrationTest
  
  def setup
		@agency = Agency.create!(number: 001, address: "Rua JK 151, Centro")
		@account = Account.create!(account_number: 1, limit: 1000, balance: 300, agency: @agency)
		@user = User.create!(email: "emerson@example.com", password: "password", password_confirmation: "password")
		@transaction = Transaction.create!(date: "27/12/2017", value: 1000, 
			type_of_transaction: "Depósito", account: @account, user: @user)
	end

	test "should get transactions index" do
  	get transactions_path
  	assert_response :success
  end

  test "should create a new valid transaction" do
    sign_in_as(@user, "password")
  	get new_transaction_path
  	assert_template 'transactions/new'
  	date_of_transaction = "14/02/2018"
  	value_of_transaction = 100
  	type_of = "Transferência"
  	assert_difference 'Transaction.count', 1 do
  		post transactions_path, params: { transaction: { date: date_of_transaction, value: value_of_transaction,
  																			type_of_transaction: type_of, account_id: @account.id, user_id: @user.id } }
  	end
  	follow_redirect!
  	assert_not flash.empty?
  end

end
