class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
    	t.integer :account_id
    	t.datetime :date
    	t.decimal :value
    	t.string :type
    	t.integer :user_id

    	t.timestamps
    end
  end
end
