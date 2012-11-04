class AddSlugToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :slug, :string
  end
end
