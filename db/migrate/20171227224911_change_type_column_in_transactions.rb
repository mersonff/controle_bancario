class ChangeTypeColumnInTransactions < ActiveRecord::Migration[5.1]
  def change
  	rename_column :transactions, :type, :type_of_transaction
  end
end
