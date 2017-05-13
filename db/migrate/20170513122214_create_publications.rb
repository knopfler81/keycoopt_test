class CreatePublications < ActiveRecord::Migration[5.0]
  def change
    create_table :publications do |t|
      t.text :title
      t.text :description
      t.text :customer

      t.timestamps
    end
  end
end
