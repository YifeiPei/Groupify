cp system_config/linux_database.yml config/database.yml
sudo bundle install
sudo mysql.server start
rake db:create
rake db:migrate
chmod 755 *.sh
echo "Done! Now you can run ./start_*.sh"