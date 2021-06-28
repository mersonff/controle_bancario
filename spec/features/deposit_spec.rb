require 'rails_helper'

feature "Deposits", type: :feature do
  before do
    user = User.create!(email: 'test@test.com', password: '123456', password_confirmation: '123456')
    agency = Agency.create!(number: 001, address: "Rua JK")
    
    visit(login_path)
    fill_in "Email",	with: user.email
    fill_in "Password", with: user.password
    click_button 'Log in'
  end

  scenario "Should deposit a value into the account" do
    agency = Agency.first
    account = Account.create!(account_number: 001, balance: 1000, limit: 1000, agency_id: agency.id )

    visit(new_transaction_path)
    select "1", :from => "transaction_account_id"
    fill_in "Valor", with: 1000
    select "Depósito", :from => "transaction_type_of_transaction"
    click_button "Salvar"
    expect(page).to have_content('Transação salva com sucesso')
  end

end
