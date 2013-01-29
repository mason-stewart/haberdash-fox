class PagesController < ApplicationController
  before_filter :nav_setup

  def about
  end

  def contact
  end

  def nav_setup
    @collections = Collection.all
  end
end
