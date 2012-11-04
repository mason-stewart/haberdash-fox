class Item < ActiveRecord::Base
  before_create :fetch_from_etsy

  def fetch_from_etsy
    item = Etsy::Listing.find(self.etsy_id)
    self.description = item.description
    self.title = item.title
    self.price = item.price
    self.url = item.url
    self.etsy_id = item.id
    self.photos = item.images
  end

  serialize :photos

  attr_accessible :description, :photos, :price, :title, :url, :etsy_id, :collection_id

  validates :etsy_id, :presence => true
  validates :etsy_id, :uniqueness => true

  belongs_to :collection
end
