class ItemsController < ApplicationController
  before_filter :nav_setup

  def nav_setup
    @collections = Collection.all
  end

  # GET /items/:slug
  def show
    @item = Item.find_last_by_slug params[:slug]
    render :show
  end
end
