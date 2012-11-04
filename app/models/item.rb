class Item < ActiveRecord::Base
  before_create :fetch_from_etsy
  after_create :save_photos

  def fetch_from_etsy
    @item = Etsy::Listing.find(self.etsy_id)
    self.description = @item.description
    self.title = @item.title
    self.price = @item.price
    self.url = @item.url
    self.etsy_id = @item.id
  end

  def save_photos
    @item.images.each do |image|
      self.photos.create(:attrs => image.result, :visible => true)
    end
  end


  attr_accessible :description, :price, :title, :url, :etsy_id, :collection_id, :photos_attributes

  validates :etsy_id, :presence => true
  validates :etsy_id, :uniqueness => true

  belongs_to :collection
  has_many :photos, :dependent => :destroy

  # Necessary for Formtastic to do nested forms.
  accepts_nested_attributes_for :photos

end
