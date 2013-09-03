class Collection < ActiveRecord::Base
  attr_accessible :active, :title, :slug

  has_and_belongs_to_many :items

  validates :slug, :title, :presence => true
  validates :slug, :uniqueness => {:case_sensitive => false}


  scope :with_at_least_n_items, ->(n = 1) { includes(:items).select { |w| w.items.size >= n } }
end