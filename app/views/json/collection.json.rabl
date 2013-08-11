object @collection
attributes :title, :slug, :etsy_shop_meta
child(:items) {
  attributes :title, :slug, :price
  node (:photo) do
    |item| item.photos.first.attrs['url_570xN']
  end
}