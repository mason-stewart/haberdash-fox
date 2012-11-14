class ItemsController < ApplicationController
  # GET /:item
  def show
    @item = Collection.find_last_by_slug params[:slug]
    render :show
  end
end
