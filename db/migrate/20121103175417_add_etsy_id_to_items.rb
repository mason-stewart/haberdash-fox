class AddEtsyIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :etsy_id, :string
  end
end
