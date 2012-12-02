namespace :db do
  task :create_item_slugs => :environment do
    Item.all.each do |item|
      if item.slug.nil?
        item.slug = item.title.gsub(/[^0-9a-z ]/i, '').gsub(/ /,'-').downcase
        item.save
        puts "Added slug '#{item.title.gsub(/[^0-9a-z ]/i, '').gsub(/ /,'-').downcase}' to '#{item.title[0..30]}'."
      else
        puts "Item '#{item.title[0..30]}'' already has slug '#{item.title.gsub(/[^0-9a-z ]/i, '').gsub(/ /,'-').downcase}'."
      end
    end
  end
end