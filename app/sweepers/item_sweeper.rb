class ItemSweeper < ActionController::Caching::Sweeper
  observe Item, Collection, Photo

  def after_create(model)
    expire_cache()
  end
 
  def after_update(model)
    expire_cache()
  end
 
  def after_destroy(model)
    expire_cache()
  end
 
  private
  def expire_cache()
    # Currently just clearing the whole cache when something is changed.
    # This needs to be refactored to a more granular approach.
    Rails.cache.clear
  end
end