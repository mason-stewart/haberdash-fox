class Item < ActiveRecord::Base
  attr_accessible :description, :photo, :price, :title, :url
end
