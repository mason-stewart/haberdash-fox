namespace :db do

  desc "This removes stale items in the db. It's called by the Heroku scheduler add-on"
  task :remove_old_items => :environment do

    Item.all.each do |item|
      @fresh_item = Etsy::Listing.find(item.etsy_id)
      if @fresh_item == nil
        puts "Shit, can't even find Listing #{item.etsy_id} on Etsy anymore..."
        item.destroy
      elsif @fresh_item.state != 'active'
        puts "#{item.etsy_id} is an inactive Listing. Removing the local record with id #{item.id}."
        item.destroy
      else
        puts "#{item.etsy_id} is still an active Listing. Keeping it!"
      end
        
    end

  end
end