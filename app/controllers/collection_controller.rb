class CollectionController < ApplicationController
  before_filter :nav_setup
  caches_action :nav_setup, :index
  cache_sweeper :item_sweeper

  def nav_setup
    @collections = Collection.where("etsy_shop_meta IS NULL")
  end

  # GET /
  def index
    @collection = Collection.includes(:items).first
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
    @shops = Collection.includes(:items).where("etsy_shop_meta IS NOT NULL")

    respond_to do |format|
      format.html
      format.json { render(file: 'json/shops') }
    end
  end
end
