class AddPhotosToItems < ActiveRecord::Migration
  def change
    add_column :items, :photos, :string_array
  end
end
