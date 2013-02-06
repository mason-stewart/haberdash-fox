ActiveAdmin.register Collection do
  config.sort_order = 'position_asc'

  index do
    column :title
    default_actions
  end

  # This action is called by javascript when you drag and drop a column
  # It iterates through the collection and sets the new position based on the
  # order that jQuery submitted them
  collection_action :sort, :method => :post do
    params[:collection].each_with_index do |id, index|
      ::Collection.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end

  form do |f|
    f.inputs "Collection Details" do
      f.input :title
      f.input :slug
      f.input :active
    end
    f.buttons
  end
end
