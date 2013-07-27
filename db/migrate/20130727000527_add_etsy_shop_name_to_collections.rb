class AddEtsyShopNameToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :etsy_shop_name, :string
  end
end
