class Collection < ActiveRecord::Base
  attr_accessible :active, :title, :slug

  has_and_belongs_to_many :items

  validates :slug, :title, :presence => true
  validates :slug, :uniqueness => {:case_sensitive => false}
end
