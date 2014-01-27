sudo rm config/database.yml
sudo cp system_config/linux_database.yml config/database.yml
sudo bundle install
sudo mysql.server start
sudo rake db:create
sudo rake db:migrate
echo "Done! Now you can run ./start_*.sh"