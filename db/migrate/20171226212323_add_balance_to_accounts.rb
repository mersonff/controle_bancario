class AddBalanceToAccounts < ActiveRecord::Migration[5.1]
  def change
  	add_column :accounts, :balance, :decimal
  end
end
