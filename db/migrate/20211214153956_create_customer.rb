class CreateCustomer < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email_address, null: false
      t.string :mobile_phone
    
      t.timestamps
    end
  end
end
