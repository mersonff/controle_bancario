class CreateAgencies < ActiveRecord::Migration[5.1]
  def change
    create_table :agencies do |t|
    	t.integer :number
    	t.text :address
    	
    	t.timestamps
    end
  end
end
