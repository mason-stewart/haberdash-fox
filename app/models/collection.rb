class Collection < ActiveRecord::Base
  attr_accessible :active, :title, :slug

  has_many :items

  validates :slug, :title, :presence => true
  validates :slug, :uniqueness => {:case_sensitive => false}
end
