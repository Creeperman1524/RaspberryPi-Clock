#! /bin/bash

# Install MagicMirror with the install script
bash -c  "$(curl -sL https://raw.githubusercontent.com/sdetweil/MagicMirror_scripts/master/raspberry.sh)"
pm2 stop MagicMirror

# Edit start file (disabling the auto restart with changes in the config, due to templates being used)
sed -i '6d' ~/MagicMirror/installers/pm2_MagicMirror_new.json
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
rm ~/MagicMirror/config.env

ln -s ~/Raspberry-Pi-Clock/config.js.template ~/MagicMirror/config/config.js.template
ln -s ~/Raspberry-Pi-Clock/config.env ~/MagicMirror/config/config.env
ln -s ~/Raspberry-Pi-Clock/custom.css ~/MagicMirror/css/custom.css

# Modules
echo "Installing custom modules..."
cd ~/MagicMirror/modules

# Planetarium
echo "Installing Planetarium..."
git clone https://github.com/MMRIZE/MMM-Planetarium

# Timeline
echo "Installing Timeline..."
git clone https://github.com/MMRIZE/MMM-CalendarExt3Timeline

# Server Status
echo "Installing Server Status..."
git clone https://github.com/XBCreepinJesus/MMM-ServerStatus.git
cd MMM-ServerStatus/
npm install
cd ~/MagicMirror/modules

# System temperature
echo "Installing system temperature..."
git clone https://github.com/MichMich/mmm-systemtemperature.git
npm install

echo "Make sure to edit the custom env file"
echo "Use 'pm2 start MagicMirror'"
