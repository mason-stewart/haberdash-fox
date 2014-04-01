# The Haberdash Fox

## Custom collections of items from the [Etsy](http://www.etsy.com) API.

![A cool screenshot of The Haberdash Fox](http://f.cl.ly/items/3c3q0G0g0s3I2E3I1p3n/Screen%20Shot%202014-02-13%20at%2012.32.57%20PM.png)

### History

This app is a labor of love from [Marco Suarez](https://twitter.com/marcosuarez) and [Mason Stewart](https://twitter.com/masondesu). We found that while it's easy to find really handsome women's clothing and accesories on [Etsy](http://www.etsy.com), it took a lot more searching to find great men's clothing.

To solve the problem, we built a simple Rails and Backbone.js app where we could feature items we loved in a clean, simple interface that worked well across all screen sizes, and with smooth, "refresh-less" movement through the app. It was the first Rails app that we ever built (both of us being strictly frontenders prior to this), and there are some hilarious mistakes in the commit log, not to mention some lingering regrets, viz. a deplorable lack of tests.

Regardless of the fact that we'd do it all completely differently if we had to do it again, Marco and I thought that the one-year anniversary of our little project would be a good time to open source it. I've recieved quite a few emails from around the world asking how we did this or that, and more than few bug reports from loyal users. This project's new status as "open source" should shed an interesting light on such inquiries.

It should be noted that Etsy's API had no mechanism, such as affiliate links, by which we could ever have made money. For a few weeks we beta-tested the idea of featuring a few sellers' entire Etsy shops and charging each shop owner a small monthly fee. Unfortunately, there simply weren't enough conversions (or even an exact way to measure them) and we went back to the "labor of love" business model of just doing this because we love it.

Although [http://thehaberdashfox.com](http://thehaberdashfox.com) is still up, we've scaled down to a single Heroku dyno and aren't actively developing new features. I think that Marco and I found at least a glimpse of the Holy Grail of software: feature-completeness. While there are certainly bugs to be fixed, specs to be written, and sloppy code to be refactored, we're satisfied with the features that exist. With that being said, we'll gladly review pull requests, bug fixes, and the like. 

Consider The Haberdash Fox not a great piece of engineering, for it most certainly is not. But as the record of two good friends hacking together on a project *simply for the love building*, it will, I hope, be of some encouragement to others.

Mason Stewart <br />
February 13th, 2014 <br />
Greenville, SC

### Installation
This is a pretty vanilla Rails app. This application requires:

* Ruby version 1.9.3
* Rails version 3.2.16
* Postgres SQL

Once you've cloned this project, you'll need these two steps first

* Run `bundle install`
* Rename `config/database.yml.example` to `config/database.yml` and fill in whatever values you prefer/need
* Run `rake db:setup`
* Rename `.env.example` to `.env` and **you must** change each of the values. You can get the Etsy API keys by creating a developer account and registering your app at [http://www.etsy.com/developers](http://www.etsy.com/developers). To generate a new Rails secret token, you can just run `rake secret` in the app's folder and copy the result into your .env file.

After this, you can start Postgres and run the server with `foreman start`. Please note that if you use `rails s` or `unicorn` without the `foreman` command, your ENV vars in `.env` won't be loaded. If you're going to be inside the Rails Console, make sure to run it with `foreman run rails c`, which will run it in the context of your `.env` file.

### Creating Items, Collections, and Shops

![A screenshot of the way cool backend interface](http://f.cl.ly/items/2Z3I3E0O2h0E3a3e1q1I/Screen%20Shot%202014-02-13%20at%202.15.50%20PM.png)

You'll want first head to http://0.0.0.0:5000/admin first and add some items. The default username and password for the ActiveAdmin backend are "admin@example.com" and "password", respectively. You should change these under the "Admin Users" section of the backend **immediately**.

Next create a new Collection under the "Collections" section. You'll find the "New Collection" button in the top right of that page. 

After this, you'll be able to add new Items. In the "Items" section, click "New Item". **Select a Collection in the multiselect, and then you'll only need to paste in an Etsy ID. The rest of the data will be slurped in automatically.**

Now when you visit the app at http://0.0.0.0:5000, you'll see a single collection and your new item in it. Repeat this until you have as many Items and Collections as you wish!

Shops behave similarly. Click on "Shops" in the menu, then "New Shop" and simply paste in an Etsy Shop Name (the owner's Etsy username), and all of the items from that shop will be added. Be careful with large shops, this operation will grab **everything**!

### Maintenance
This app comes with a rake task (`rake db:remove_old_items`) that can be called from the Heroku Scheduler (or some cron-like). As the name indicates, it will hit the Etsy API and check the status of items, and remove from the app's database any items that are no longer for sale on Etsy. If your server is beefy, you may end up going over the Etsy API rate limit. Etsy will email you if you do :D

### Deployment
The Haberdash Fox was built to run on [Heroku](http://heroku.com), and as such is very simple to deploy. Assuming you alredy have a Heroku account and the Heroku toolkit setup, you'll just need to run `heroku create` copy your ENV vars from `.env` manually, or use the [heroku-config](https://github.com/ddollar/heroku-config) tool to copy them automagically. Don't forget to do `heroku run rake db:setup` after your first deploy, and **please remember to change the default username and password**!


### License

The Haberdash Fox is licensed under the The MIT License (MIT)

Copyright (c) 2012-2014 [Marco Suarez](https://twitter.com/marcosuarez), [Mason Stewart](https://twitter.com/masondesu)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
