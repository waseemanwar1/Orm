class CreatePurchaseOrderStatus < ActiveRecord::Migration[6.1]
  def change
    create_table :purchase_order_statuses do |t|
      t.integer :status, null: false

      t.timestamps
    end
  end
end
