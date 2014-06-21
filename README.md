This is the core __Groupify__ website repository. It contains the Ruby on Rails app that can be seen at [Groupify](www.groupify.com.au).
================================================================

This repository is for development of the __Groupify__ website. It is in version __0.01__.
----------------------------------------------------------

### How do I get set up? ###

1. Summary of set up
2. Configuration
3. Dependencies
4. Database configuration
5. How to run tests
6. Deployment instructions

## 1. Summary of set up

In production __Groupify__ is hosted on a ubuntu server running nginx with the passenger module. 

For development we usually run the rails webbrick server. These instructions are for setting up on a linux box, typically ubuntu's latest version. If you run a different OS, you can download [virtualbox](https://www.virtualbox.org/) for free, and download a [ubuntu desktop](http://www.ubuntu.com/download/desktop) version for free too. This README will take you through the basics of what should be required to get up and running.
 
## 2. Configuration

For development you will need to install the following:
+ git
+ ruby
+ mysql

On ubuntu you can do this with the command:
> `sudo apt-get install build-essential git ruby make ruby-dev mysqlserver libmysqlclient-dev`

## 3. Dependencies

You will need to install rails with `sudo gem install rails`. 

## 4. Database setup

The mysql database will need a user groupify. You can contact us via the details below for the password that we use. Running `rake db:create` in the root of the app (once you've downloaded it with git) should create the appropriate databases and tables.

## 5. How to run tests

Um. Yeah. We really need to get on top of this bit.

## 6. Deployment instructions

To deploy, ssh into the current server using the keypair and ip in the _resources_ repo.
Once there follow the README (reposted here for convenience).

To redeploy our groupify web app follow these steps:

1. Remove all the precompiled assets in *trunk\_old/public/assets*

2. Run `git pull` in the *trunk\_old* directory

3. Run `bundle install`

4. Run `rake db:migrate`

5. Run `RAILS_ENV=production bundle exec rake assets:precompile`

6. Delete all files in */srv/groupify* directory using `sudo rm -rf /srv/groupify/*`

7. Copy trunk_old into */srv/groupify* using `sudo cp -r * /srv/groupify/`
while inside the *trunk\_old* directory

8. Restart the nginx server using `sudo /opt/nginx/sbin/nginx -s reload`

### Contribution guidelines ###

* Writing tests
* Code review
* Other guidelines

TBA

### Who do I talk to? ###

To find out more contact Des at des.wagner at alumni.adelaide.edu.au.

And you can try yifei at groupify.com.au