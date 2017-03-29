follow the instuctions here:

first do this:
https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-14-04
then this:
https://www.digitalocean.com/community/tutorials/deploying-a-rails-app-on-ubuntu-14-04-with-capistrano-nginx-and-puma

*set up swap
https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-14-04


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
also go into console (`psql`) and \l lists databases, \du displays users.


---------------------------
capistrano problems with js runtime.  Installing node-js fixed this.
sudo apt-get install nodejs



start installing rvm etc
------------------------
`gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3`


`curl -sSL https://get.rvm.io | bash -s stable`
`source /home/deploy/.rvm/scripts/rvm`
`rvm requirements`
`rvm install 2.4.0`

`gem install rails -V 5.0.1 -V --no-ri --no-rdoc`
`gem install bundler -V --no-ri --no-rdoc`


`ssh-keygen -t rsa`  and add to github ssh keys.

swap
----
sudo mkswap swapfile
sudo chmod 600 swapfile
sudo swapon -s
sudo swapon swapfile
free -m
edit /etc/fstab   to make use of swapfile permanent.

**** to do *** now begin step 6 deploy it!
port number ?


To Do
-----

*Optimise as per the conclusion in the guide.
* think about swapiness.



Deploy
------

<%= ENV['WWW_DATABASE_PASSWORD'] %>

try the solution here:  http://railsguides.net/how-to-define-environment-variables-in-rails/

didn;t work because the symlink didn't work:
so:
hardcode the password in bitbucket.  (temporary solution)





