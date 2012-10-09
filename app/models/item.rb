class Item < ActiveRecord::Base
  attr_accessible :description, :photo, :price, :title, :url

  belongs_to :collection
end
