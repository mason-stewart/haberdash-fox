class ItemsController < ApplicationController
  include ActionView::Helpers::TextHelper

  before_filter :nav_setup
  caches_action :nav_setup
  cache_sweeper :item_sweeper

  def nav_setup
    @collections = Collection.where("etsy_shop_meta IS NULL")
  end

  # GET /items/:slug
  def show
    @item = Item.includes(:collections).find_last_by_slug params[:slug]

    @description = @item.description.gsub( %r{http://[^\s<]+} ) do |url|
      "<a href='#{url}'>#{url}</a>"
    end

    @title = simple_format @item.title
    @description = simple_format @description

    respond_to do |format|
      format.html
      format.json { render(file: 'json/item', object: @item, formats: :json) }
    end
  end
end
