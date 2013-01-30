class AddPostitionToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :position, :integer
  end
end
