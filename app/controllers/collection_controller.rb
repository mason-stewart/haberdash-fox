class CollectionController < ApplicationController
  before_filter :nav_setup
  caches_action :nav_setup, :index
  cache_sweeper :item_sweeper

  def nav_setup
    @collections = Collection.all
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
      format.json { render(file: 'json/collection', object: @collection, formats: :json) }

    end
  end
end
