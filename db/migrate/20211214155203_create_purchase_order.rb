class CreatePurchaseOrder < ActiveRecord::Migration[6.1]
  def change
    create_table :purchase_orders do |t|
      t.string :supplier_id
      t.string :created_by
      t.date :creation_date
      t.decimal :shipping_fee
      t.decimal :taxes
      t.decimal :payment_amount
      t.integer :payment_method

      t.timestamps
    end
  end
end
