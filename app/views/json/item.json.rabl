object @item
node(:title) {
  |item| simple_format item.title
}
node(:description) {
  |item| simple_format item.description
}
attributes :price, :slug, :url
child(:collections) {
  attributes :title, :slug
}
child(:photos) {
  node (:url) do
    |photo| photo.attrs['url_fullxfull']
  end
}