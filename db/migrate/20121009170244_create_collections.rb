class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :title
      t.boolean :active

      t.timestamps
    end
  end
end
