collection @items
attributes :title, :price, :slug, :url, :description
child(:collection) {
  attributes :title, :slug
}
child(:photos) {
  node (:url) do
    |photo| photo.attrs['url_fullxfull']
  end
}