cp system_config/ubuntu_database.yml config/database.yml
sudo bundle install
sudo service mysql start
rake db:create
rake db:migrate
echo "Done! Now you can run ./start_*.sh"