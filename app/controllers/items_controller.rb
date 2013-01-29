class ItemsController < ApplicationController
  before_filter :nav_setup

  def nav_setup
    @collections = Collection.all
  end

  # GET /items/:slug
  def show
    @item = Item.find_last_by_slug params[:slug]

    @description = @item.description.gsub( %r{http://[^\s<]+} ) do |url|
      "<a href='#{url}'>#{url}</a>"
    end

    render :show
  end
end
