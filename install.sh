#! /bin/bash

# Install MagicMirror with the install script
bash -c  "$(curl -sL https://raw.githubusercontent.com/sdetweil/MagicMirror_scripts/master/raspberry.sh)"
pm2 stop MagicMirror

# Edit start file
sed -i 's/config.js/config.js.template/' ~/MagicMirror/installers/pm2_MagicMirror_new.json # watches the template file instead
pm2 start ~/MagicMirror/installers/pm2_MagicMirror_new.json
pm2 save
pm2 stop MagicMirror

# Turn off screensaver
echo "Disabling screensaver... (backup)"
bash -c "$(curl -sL https://raw.githubusercontent.com/sdetweil/MagicMirror_scripts/master/screensaveroff.sh)"

# Symlink configuration
echo "Installation complete! Linking custom configuration..."
rm ~/MagicMirror/config/config.js
rm ~/MagicMirror/config/config.js.template
rm ~/MagicMirror/css/custom.css
rm ~/MagicMirror/config/config.env

ln -s ~/RaspberryPi-Clock/config.js.template ~/MagicMirror/config/config.js.template
cp ~/RaspberryPi-Clock/config.env.example ~/RaspberryPi-Clock/config.env
ln -s ~/RaspberryPi-Clock/config.env ~/MagicMirror/config/config.env
ln -s ~/RaspberryPi-Clock/custom.css ~/MagicMirror/css/custom.css

# Modules
echo "Installing custom modules..."
cd ~/MagicMirror/modules

# Timeline
echo "Installing Timeline..."
git clone https://github.com/MMRIZE/MMM-CalendarExt3Timeline &> /dev/null

# Server Status
echo "Installing Server Status..."
git clone https://github.com/XBCreepinJesus/MMM-ServerStatus.git &> /dev/null
cd MMM-ServerStatus/
npm install
cd ~/MagicMirror/modules

# System temperature
echo "Installing system temperature..."
git clone https://github.com/MichMich/mmm-systemtemperature.git &> /dev/null
npm install

# Temperature monitor
echo "Installing temperature monitor..."
git clone https://github.com/grenagit/MMM-DHT-Sensor &> /dev/null
cd MMM-DHT-Sensor
npm install
cd ~/MagicMirror/modules

# Scenes
echo "Installing scenes..."
git clone https://github.com/MMRIZE/MMM-Scenes2 &> /dev/null
cd MMM-Scenes2
npm install
cd ~/MagicMirror/modules

# Create folder for my custom module
echo "Installing custom touch handler..."
mkdir MMM-TouchHandler
ln -s ~/RaspberryPi-Clock/MMM-TouchHandler.js ~/MagicMirror/modules/MMM-TouchHandler/MMM-TouchHandler.js

# Notification Scheduler
echo "Installing notification scheduler..."
git clone https://github.com/ianperrin/MMM-ModuleScheduler.git &> /dev/null
cd MMM-ModuleScheduler
npm install --production
cd ~/MagicMirror/modules

echo "Make sure to edit the custom env file"
echo "Use 'pm2 start MagicMirror'"
