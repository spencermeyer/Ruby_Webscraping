# Ruby_Webscraping
A Webscraping Application using Rails 5 and Ruby 2.4.4

This is a webscraping applicaiton for my local running club who like to compile results from Parkruns where out local club members have visited.

The scraping is done in two stages: 1) there is an index site where the list of sites where results are available is held, and then 2) the app goes to each of these sites to get the information.

I'm using 'mechanize' as my scraping gem:  I started using Nokogiri but I found that I could not set headers to defeat anti-scraping measures using this, and found that mechanize just works.

I started using Postgressql because MySQL was not accepted by Heroku, however due to problems with Heroku, I started hosting this on a cloud computer and just continued using Postgres.

I initially tried Heroku to host this.  However the app times out because it has a lot to do before the view can be displayed - particularly a lot of http which are costly and unavoidable.  I was not able to alter the http timeout on Heroku so I went to hosting this on a Digital Ocean Droplet, which obviously alllows me to alter the timeout - and lets me learn about Capistrano, nginx, and all the ohther stuff that things like Heroku just does for you.

For testing, I set up a Sinatra server (hosted in a different Git repository) to serve up test assets in development and test modes, and I'm using the 'vcr' gem to replay it in test mode.

Deployment.
-----------
I've written a separate document for my Digital Ocean machine build log, it took a long time to get this right.
To deploy subsequent code, it is simply:
	`cap production deploy`
which is really convenient.

Things to do next.
------------------
* lots more styling.
* make it more robust for http fails.
* make it send emails for upcoming milestones.
* make a cron job for scraping so that the results are all ready for the user to see.

Tech Stack
----------
* Capistrano 3 for deployment
* Puma runs rails 5
* Ruby 2.4.4  :)
* posgresql
* nginx
