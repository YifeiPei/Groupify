sudo rm config/database.yml
sudo cp system_config/ubuntu_database.yml config/database.yml
sudo bundle install
sudo service mysql start
sudo rake db:create
sudo rake db:migrate
echo "Done! Now you can run ./start_*.sh"