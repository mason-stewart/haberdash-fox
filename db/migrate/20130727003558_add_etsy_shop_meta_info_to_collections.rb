class AddEtsyShopMetaInfoToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :etsy_shop_meta, :text
  end
end
