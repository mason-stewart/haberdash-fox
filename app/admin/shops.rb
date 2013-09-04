ActiveAdmin.register Shop do
  config.sort_order = 'position_asc'

  index do
    column :title
    column :etsy_shop_name
    default_actions
  end

  form do |f|
    f.inputs "Collection Details" do
      f.input :title
      f.input :slug
      f.input :etsy_shop_name
      f.input :active
    end
    f.buttons
  end
end
