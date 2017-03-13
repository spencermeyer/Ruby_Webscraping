follow the instuctions here:

first do this:
https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-14-04
then this:
https://www.digitalocean.com/community/tutorials/deploying-a-rails-app-on-ubuntu-14-04-with-capistrano-nginx-and-puma




add a user 'deploy'
`adduser deploy`

grant sudo access to deploy
`gpasswd -a deploy sudo`

make `.ssh/authorized_keys`
`chmod 600 authorized_keys`

`sudo apt-get update`

install nginx:
`sudo apt-get install curl git-core nginx -y`

I'm at step 2 installing databases:
Have to do this:
https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-ubuntu-14-04

`sudo apt-get install postgresql postgresql-contrib libpq-dev`
`sudo -u postgres createuser -s pguser`

				psql: FATAL:  role "deploy" does not exist  **************** to do 



start installing rvm etc
------------------------
`gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3`


`curl -sSL https://get.rvm.io | bash -s stable`
`source /home/deploy/.rvm/scripts/rvm`
`rvm requirements`
`rvm install 2.4.0`

**** to do *** now begin step 4 installing Rails and Bundler.





