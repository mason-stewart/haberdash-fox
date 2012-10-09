class Collection < ActiveRecord::Base
  attr_accessible :active, :title

  has_many :items
end
