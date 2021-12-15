class CreateOrder < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.date :order_date
      t.date :shipped_date
      t.decimal :shipping_fee
      t.decimal :taxes
      t.string :payment_type

      t.timestamps
    end
  end
end
