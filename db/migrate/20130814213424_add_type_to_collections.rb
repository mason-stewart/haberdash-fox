class AddTypeToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :type, :string
  end
end
