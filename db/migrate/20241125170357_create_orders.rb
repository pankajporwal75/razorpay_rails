class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.float :amount
      t.string :status

      t.timestamps
    end
  end
end
