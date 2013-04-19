require 'spec_helper'

describe Item do
  
  describe "Creating an Item" do
    it "should fail without an etsy_id" do
      item = FactoryGirl.build(:item)
      item.save.should be_false
    end

    it "should succeed with a unique etsy_id" do
      item = FactoryGirl.build(:item)
      item.etsy_id = 44652014
      item.save.should be_true
    end
  end
end
