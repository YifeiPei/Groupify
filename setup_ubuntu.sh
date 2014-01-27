cp system_config/ubuntu_database.yml config/database.yml
bundle install
sudo service mysql start
rake db:create
rake db:migrate
chmod 755 *.sh
echo "Done! Now you can run ./start_*.sh"
