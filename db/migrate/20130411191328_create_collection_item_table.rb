class CreateCollectionItemTable < ActiveRecord::Migration
  def self.up
    create_table :collections_items, :id => false do |t|
      t.integer :collection_id
      t.integer :item_id
    end

    Item.all.each do |item|
      unless item.collection_id.nil?
        collection = Collection.find(item.collection_id)
        item.collections << collection
        item.save
      end
    end
  end

  def self.down
    drop_table :collections_items
  end
end
