class Photo < ActiveRecord::Base
  attr_accessible :attrs, :item_id, :visible

  serialize :attrs

  belongs_to :item
end
