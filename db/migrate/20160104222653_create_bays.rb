class CreateBays < ActiveRecord::Migration
  def change
    create_table :bays do |t|
      t.string :code
      t.integer :position

      t.timestamps null: false
    end
  end
end
