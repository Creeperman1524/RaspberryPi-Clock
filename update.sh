#! /bin/bash

# Only install production dependencies to save on space and time
export NODE_ENV=production

# Updates the main Magic Mirror
echo "Updating Magic Mirror..."
cd ~/MagicMirror
git restore . &> /dev/null
git pull &> /dev/null
npm i

# Updates all modules
echo "Updating modules..."
modules=("${HOME}"/MagicMirror/modules/*)

for module in "${modules[@]}"; do
	cd "$module"
	if [ -d "${module}/.git" ]; then
		git pull &> /dev/null
		npm i
		npm audit fix
	fi
done

echo "Make sure to restart your MagicMirror with 'pm2 restart MagicMirror'"
