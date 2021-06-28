require 'rails_helper'

feature "Accounts", type: :feature do
  before do
    user = User.create!(email: 'test@test.com', password: '123456', password_confirmation: '123456')
    agency = Agency.create!(number: 001, address: "Rua JK")
    
    visit(login_path)
    fill_in "Email",	with: user.email
    fill_in "Password", with: user.password
    click_button 'Log in'
  end

  scenario 'Should create a new account' do
    visit(new_account_path)
    expect(page).to have_selector('h1', text: 'Adicionando nova conta')
    select "Rua JK", :from => "account_agency_id"
    fill_in "Número da Conta", with: 001
    fill_in "Saldo", with: 1000
    fill_in "Limite", with: 1000
    click_button "Salvar"
    expect(page).to have_content('Conta cadastrada com sucesso')
  end

  scenario 'Should update a account' do
    agency = Agency.first
    account = Account.create!(account_number: 001, balance: 1000, limit: 1000, agency_id: agency.id )

    new_number = 002
    visit(edit_account_path(account.id))
    expect(page).to have_selector('h1', text: 'Editar informação da conta')
    fill_in "Número da Conta", with: new_number
    click_button "Atualizar"
    expect(page).to have_content('Conta atualizada com sucesso')
  end

  scenario 'Account should not be deleted', js: true do 
    agency = Agency.first
    account = Account.create!(account_number: 001, balance: 1000, limit: 1000, agency_id: agency.id )

    visit(accounts_path)
    find(:xpath, "/html/body/div[2]/table/tbody/tr/td[5]/a[2]").click
    page.driver.browser.switch_to.alert.accept

    expect(page).to have_content('Contas não podem ser apagadas')
  end

end
