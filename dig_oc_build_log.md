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


Symlink the nginx conf
----------------------
sudo ln -nfs "/home/deploy/apps/Rubyscrape/current/config/nginx.conf" "/etc/nginx/sites-enabled/Rubyscrape"

in apps/Rubyscrape/shared/config   put the config files and add a capistrano task to  symlink them
https://www.varvet.com/blog/handle-secret-credentials-in-ruby-on-rails/
http://www.freelancingdigest.com/articles/capistrano-variables/


install redis
-------------
steps are here: https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-redis-on-ubuntu-16-04
sudo apt-get install build-essential tcl
cd /tmp
curl -O http://download.redis.io/redis-stable.tar.gz
tar xzvf redis-stable.tar.gz
cd redis-stable
make
make test
sudo make install
sudo mkdir /etc/redis
sudo cp /tmp/redis-stable/redis.conf /etc/redis
- then change the redis.conf to the settings given in the difital ocean guide.
/etc/systemd/system/redis.service     and add the setting given in the guide
sudo adduser --system --group --no-create-home redis
sudo mkdir /var/lib/redis
sudo chown redis:redis /var/lib/redis
sudo chmod 770 /var/lib/redis
sudo systemctl enable redis

install ssl certificate
-----------------------
based on this:  https://www.digitalocean.com/community/tutorials/how-to-create-an-ssl-certificate-on-nginx-for-ubuntu-14-04

mkdir /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt

THIS IS NOT WORKING MUST GET THIS WORKING...

Set up IP Tables
----------------
https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-using-iptables-on-ubuntu-14-04
MUST DO MORE OF THIS, SEE THE VISITS!

To Do
-----

*Optimise as per the conclusion in the guide.
* think about swapiness.
<%= ENV['WWW_DATABASE_PASSWORD'] %>


rake task to clear out old visits

Deploy
------ 
This site is hosted at:  parkcollectoronrails.co.uk   (46.101.17.87)

try the solution here:  http://railsguides.net/how-to-define-environment-variables-in-rails/

didn;t work because the symlink didn't work:
so:
hardcode the password in bitbucket.  (temporary solution)

here is how to test:  `nginx -t`

problem: timeout


