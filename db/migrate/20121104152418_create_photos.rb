class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :attrs
      t.integer :item_id

      t.timestamps
    end
  end
end
