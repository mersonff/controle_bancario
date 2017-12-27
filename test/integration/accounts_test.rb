require 'test_helper'

class AccountsTest < ActionDispatch::IntegrationTest
  def setup
		@agency = Agency.create!(number: 1, address: "Rua JK, 151, Centro")
		@account = Account.create(account_number: 1, limit: 1000.00, balance: 300, agency: @agency)
		@account2 = @agency.accounts.build(account_number: 2, limit: 2000.00, balance: 400, agency: @agency)
		@account2.save
	end
  
  test "should get accounts index" do
  	get accounts_path
  	assert_response :success
  end

  test "should get accounts listing" do
  	get accounts_path
  	assert_template 'accounts/index'
  	assert_select 'a[href=?]', edit_account_path(@account), text: "Editar"
  	assert_select 'a[href=?]', account_path(@account), text: "Deletar"
  end

  test "should create a new valid account" do
  	get new_account_path
  	assert_template 'accounts/new'
  	number_of_account = 3
  	limit_of_account = 3000
  	balance_of_account = 500
  	assert_difference 'Account.count', 1 do
  		post accounts_path, params: { account: { account_number: number_of_account, limit: limit_of_account, 
  			balance: balance_of_account, agency_id: @agency.id } }
  	end
  	follow_redirect!
  	assert_select 'div.alert-success'
  end

  test "should reject a invalid account" do
  	get new_account_path
  	assert_template 'accounts/new'
  	assert_no_difference 'Account.count' do
  		post accounts_path, params: { account: { account_number: nil, limit: nil, balance: nil, agency_id: nil } }
  	end
  	assert_template 'accounts/new'
  	assert_select 'h2.error-title'
  	assert_select 'div.error-body'
  end

  test "successfully account update" do
  	get edit_account_path(@account)
  	assert_template 'accounts/edit'
  	updated_account_number = 4
  	updated_account_limit = 4000
  	updated_account_balance = 400
  	patch account_path(@account), params: { account: { account_number: updated_account_number, 
  		limit: updated_account_limit, balance: updated_account_balance, agency_id: @agency.id } }
  	follow_redirect!
  	assert_not flash.empty?
  	assert_select 'div.alert-success'
  end

  test "reject a invalid account update" do
  	get edit_account_path(@account)
  	assert_template 'accounts/edit'
  	patch account_path(@account), params: { account: { account_number: nil, 
  		limit: nil, balance: nil, agency_id: nil } }
  	assert_template 'accounts/edit'
  	assert_select 'h2.error-title'
  	assert_select 'div.error-body'
  end

  test "successfully account delete" do
  	get accounts_path
  	assert_template 'accounts/index'
  	assert_select 'a[href=?]', account_path(@account), text: "Deletar"
  	assert_difference 'Account.count', -1 do
  		delete account_path(@account)
  	end
  	assert_redirected_to accounts_path
  	assert_not flash.empty?
  end
end
