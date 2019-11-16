# Ruby_Webscraping
A Webscraping Application using Rails 5 and Ruby 2.4.4

This is a webscraping applicaiton for my local running club who like to compile results from Parkruns where out local club members have visited.

The scraping is done in two stages: 1) there is an index site where the list of sites where results are available is held, and then 2) the app goes to each of these sites to get the information.

I'm using 'mechanize' as my scraping gem:  I started using Nokogiri but I found that I could not set headers to defeat anti-scraping measures using this, and found that mechanize just works.

I started using Postgressql because MySQL was not accepted by Heroku, however due to problems with Heroku, I started hosting this on a cloud computer and just continued using Postgres.

I initially tried Heroku to host this.  However the app times out because it has a lot to do before the view can be displayed - particularly a lot of http which are costly and unavoidable.  I was not able to alter the http timeout on Heroku so I went to hosting this on a Digital Ocean Droplet, which obviously alllows me to alter the timeout - and lets me learn about Capistrano, nginx, and all the ohther stuff that things like Heroku just does for you.

For local testing, I am using a python server that serves a set of websites copied from parkrun so that I do not keep requesting them from parkrun, I simply alter my HOSTS file to redirect traffic to my local server for testing.  For test mode I'm using the 'vcr' gem to replay requests to parkrun.

When put into production, I found I was getting a connection refused when making too many requests too quickly,  I therefore broke the requests up into individual jobs which fire at 10 second intervals using Resque delayed job.  This has made is more reliable and of course it still collects data if one job fails.  I've got Resque-Schedule set up to do some database administration jobs for me in the background.

The app is database heavy and takes time to do the scraping.
To optimise this I've collected all the data in a massive hash and then saved it all in one db transaction at the end instead of individual transactions.  I do various age grade and age category positions allocations on the hash before saving, this is MUCH faster than using active record saves individually.

Deployment.
-----------
I've written a separate document for my Digital Ocean machine build log, it took a long time to get this right.
To deploy subsequent code, it is simply:
	`cap production deploy`
which is really convenient.

Things to do next.
------------------
1 make it send emails for upcoming milestones.
2 make a React view consuming the json to sit alongside the existing rails view.
3 extend the stalker feature to get the stalkees wherever they run.
4 double collection problem ?  I only run one worker on prod.  Have just moved this over to resque only.  See if it still happens.
5 upgrade ruby and gems because of security warnings.

Tech Stack
----------
* Capistrano 3 for deployment
* Puma runs rails 5
* Ruby 2.4.4  :)
* posgresql
* nginx
* resque


Current Revision on the Server
------------------------------
acdef59d3df81df8d1a934e7bec24c00910d53bc  REVISION file gives the current version deployed.


