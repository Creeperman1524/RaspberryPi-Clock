# RaspberryPi-Clock

A location to store and keep track of configuration files for my Raspberry Pi Clock project.

It also provides a script to easily add all the features for the [MagicMirror](https://magicmirror.builders/).

# Hardware

Coming soon!

# Software

Run `./install.sh` to install MagicMirror, my modules, and configurations. It will:

1. Run the install script provided by [this repository](https://github.com/sdetweil/MagicMirror_scripts).
2. Edit some files created by the installation for more ease of use.
3. Symlink all configuration files to this repository
   - That way, any changes made to the repo can instantly be `git pull`'ed and viewed
4. Disable the clock's screensaver
5. Enable auto restarts

## Commands

`pm2 start MagicMirror`

`pm2 reload MagicMirror`

`pm2 stop MagicMirror`
