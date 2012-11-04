class Photo < ActiveRecord::Base
  attr_accessible :attrs, :item_id

  serialize :attrs

  belongs_to :item
end
