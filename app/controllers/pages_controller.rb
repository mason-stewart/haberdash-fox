class PagesController < ApplicationController
  before_filter :nav_setup
  caches_action :nav_setup, :about, :contact
  cache_sweeper :item_sweeper

  def about
  end

  def contact
  end

  def nav_setup
    @collections = Collection.order(:position).where("etsy_shop_meta IS NULL")
    @featured_collection = Collection.order(:position).with_at_least_n_items.first
  end
end
