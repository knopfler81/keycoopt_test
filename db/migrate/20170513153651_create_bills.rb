class CreateBills < ActiveRecord::Migration[5.0]
  def change
    create_table :bills do |t|
      t.float :amount
      t.references :publication
      t.string :reference


      t.timestamps
    end
  end
end
