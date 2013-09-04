class Shop < Collection

  before_destroy {
    self.items.each do |item|
      item.destroy
    end

    self.items.delete_all 
    p self.items
  }
  before_create :fetch_shop_meta_from_etsy
  after_create :fetch_shop_items_from_etsy

  attr_accessible :etsy_shop_name, :etsy_shop_meta
  serialize :etsy_shop_meta, JSON

  def fetch_shop_meta_from_etsy
    unless self.etsy_shop_name.empty?
      @query = Etsy::Shop.find(self.etsy_shop_name, {:includes => ['About']})
      self.etsy_shop_meta = @query.result

      @query = Etsy::User.find(self.etsy_shop_meta['login_name'], {:includes => 'Profile'})
      self.etsy_shop_meta['User'] = @query.result

      self.etsy_shop_meta['title'].gsub! /&#39;/, "'"
      self.etsy_shop_meta['User']['Profile']['bio'].gsub! /&#39;/, "'"
    end
  end

  def fetch_shop_items_from_etsy
    unless self.etsy_shop_name.empty?
      @shop_items = Etsy::Listing.find_all_by_shop_id(self.etsy_shop_name, {
        :limit => 250
      })
      @shop_items.each do |item|
        new_item = Item.new
        new_item.description = item.description
        new_item.title = item.title
        new_item.price = item.price
        new_item.url = item.url
        new_item.etsy_id = item.id
        new_item.slug = item.title.gsub(/[
          ^0-9a-z ]/i, '').gsub(/ /,'-').downcase
        new_item.collections << self
        new_item.save
      end
    end
  end

  # doing this to prevent ActiveAdmin from messing up jQuery serialization.
  def self.model_name
    ActiveModel::Name.new(Collection)
  end
end