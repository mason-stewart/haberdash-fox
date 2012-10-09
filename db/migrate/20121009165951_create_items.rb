class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.string :photo
      t.integer :price
      t.string :url

      t.timestamps
    end
  end
end
