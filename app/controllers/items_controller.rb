class ItemsController < ApplicationController
  before_filter :nav_setup
  caches_action :nav_setup
  cache_sweeper :item_sweeper

  def nav_setup
    @collections = Collection.all
  end

  # GET /items/:slug
  def show
    @item = Item.includes(:collections).find_last_by_slug params[:slug]

    @description = @item.description.gsub( %r{http://[^\s<]+} ) do |url|
      "<a href='#{url}'>#{url}</a>"
    end

    respond_to do |format|
      format.html
      format.json { render(file: 'json/item', object: @item, formats: :json) }
    end
  end
end
