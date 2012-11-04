# A custom input class for showing an image next to a check box
class CheckBoxImagesInput < Formtastic::Inputs::CheckBoxesInput
  def check_box_images_html_options
    {:class => 'check-box-image'}.merge(options[:image_html] || {})
  end

  def to_html
    input_wrapping do
      label_html <<
      image_html <<
      builder.check_box(method, input_html_options)
    end
  end

protected

  def image_html
    return "".html_safe if builder.object.new_record?

    url = case options[:image]
    when Symbol
      builder.object.send(options[:image])
    when Proc # It accepts a proc, which is helpful for getting the photo url
      options[:image].call(builder.object)
    else
      options[:image].to_s
    end

    builder.template.image_tag(url, check_box_images_html_options).html_safe
  end
end

ActiveAdmin.register Item do

  form do |f|
    f.inputs "Item Details" do
      f.input :etsy_id, :label => 'Etsy Item ID'
      f.input :title
      f.input :description
      f.input :price
      f.input :url
      # Use ActiveAdmin's cool has_many trick in conjunction with the
      # custom input class above
      f.has_many :photos do |j|
        j.input :visible, :as => :check_box_images,
                          :label => 'Visible?',
                          :image => proc { |photo| photo.attrs['url_75x75'] }
      end
    end
    f.buttons
  end

  show do |f|
    attributes_table do
      row :etsy_id
      row :title
      row :description
      row :price
      row :photos do
        item.photos.where(:visible => true).each do |photo|
          span image_tag photo.attrs['url_75x75']
        end
      end
    end
  end
end
