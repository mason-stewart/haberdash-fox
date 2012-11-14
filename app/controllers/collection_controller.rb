class CollectionController < ApplicationController
  before_filter :nav_setup

  def nav_setup
    @collections = Collection.all
  end

  # GET /
  def index
    @collection = Collection.first
    render :show
  end

  # GET /:collection
  def show
    @collection = Collection.find_last_by_slug params[:slug]
    render :show
  end
end
