class CollectionController < ApplicationController
  before_filter :nav_setup
  caches_action :nav_setup, :index
  cache_sweeper :item_sweeper

  def nav_setup
    @collections = Collection.order(:position).where("etsy_shop_meta IS NULL")
  end

  # GET /
  def index
    @collection = Collection.order(:position).with_at_least_n_items.first
    render :show
  end

  # GET /collection/:slug
  def show
    @collection = Collection.includes(:items).find_last_by_slug params[:slug]

    respond_to do |format|
      format.html
      format.json { render(file: 'json/collection') }
    end
  end

  # GET /shops
  def shops
    @shops = Collection.order(:position).where("etsy_shop_meta IS NOT NULL").with_at_least_n_items
    
    respond_to do |format|
      format.html { render :shops }
      format.json { render(file: 'json/shops') }
    end
  end
end
