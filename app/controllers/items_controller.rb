class ItemsController < ApplicationController
  before_filter :nav_setup
  caches_action :nav_setup, :show
  cache_sweeper :item_sweeper

  def nav_setup
    @collections = Collection.includes(:items => :photos).all
    @items = Item.includes(:collections).includes(:photos).all
  end

  # GET /items/:slug
  def show
    @item = Item.includes(:collections).includes(:photos).find_last_by_slug params[:slug]

    @description = @item.description.gsub( %r{http://[^\s<]+} ) do |url|
      "<a href='#{url}'>#{url}</a>"
    end

    render :show
  end
end
