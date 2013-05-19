namespace :db do

  desc "This removes stale items in the db. It's called by the Heroku scheduler add-on"
  task :remove_old_items => :environment do

    Item.all.each do |item|
      @fresh_item = Etsy::Listing.find(item.etsy_id)
      if @fresh_item == nil
        puts "Shit, Listing #{item.etsy_id} returning nil... are we over the API rate-limit?"
      elsif @fresh_item.state != 'active'
        puts "#{item.etsy_id} is an inactive Listing. Removing the local record with id #{item.id}."
        item.destroy
      else
        puts "#{item.etsy_id} is still an active Listing. Keeping it!"
      end
      sleep 1
    end

    # Use this for hosing the Etsy API if you need to find out
    # what happens when you go over the API limit.
    #
    # for i in 0..1000
    #   Thread.new(i) do |i|
    #     @fresh_item = Etsy::Listing.find('114137334')
    #     puts "#{i} = #{@fresh_item.inspect}"
    #     puts
    #   end
    # end

  end
end