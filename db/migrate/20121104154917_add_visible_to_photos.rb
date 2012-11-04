class AddVisibleToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :visible, :boolean
  end
end
