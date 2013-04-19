class PagesController < ApplicationController
  before_filter :nav_setup
  caches_action :nav_setup, :about, :contact
  cache_sweeper :item_sweeper

  def about
  end

  def contact
  end

  def nav_setup
    @collections = Collection.includes(:items => :photos).all
    @items = Item.includes(:collections).includes(:photos).all
  end
end
