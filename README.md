# RaspberryPi-Clock

A location to store and keep track of configuration files for my Raspberry Pi Clock project.

It also provides a script to easily add all the features for the [MagicMirror<sup>2</sup>](https://magicmirror.builders/) display used for this project.

- [RaspberryPi-Clock](#raspberrypi-clock)
  - [Hardware](#hardware)
  - [Software](#software)
    - [Clock Display](#clock-display)
      - [Commands](#commands)
      - [Features](#features)
    - [Screen Orientation](#screen-orientation)
    - [Auto dimming](#auto-dimming)
    - [Temperature monitoring](#temperature-monitoring)
  - [Tips and Tricks](#tips-and-tricks)
    - [View CPU temperature](#view-cpu-temperature)
    - [Reduce shutdown power consumption](#reduce-shutdown-power-consumption)
    - [Turn off LED power light](#turn-off-led-power-light)
- [Credits](#credits)

## Hardware

Coming soon!

## Software

### Clock Display

Run `./install.sh` to install MagicMirror<sup>2</sup>, my modules, and configurations.

> [!WARNING]
> This does take a while to run, especially to install all the packages. Be patient and make sure to not power off the Pi!

This script will:

1. Run the install script provided by [this repository](https://github.com/sdetweil/MagicMirror_scripts) to install MagicMirror<sup>2</sup>.
2. Edit some files created by the installation for more ease of use.
3. Symlink all configuration files to this repository.
   - That way, any changes made to the repo can instantly be `git pull`'ed and updated.
4. Install all the modules that I use and have created.
5. Disable the pi's screensaver.
6. Enable auto-start for when the Pi is restarted/shutdown.

#### Commands

By `ssh`ing into the Raspberry Pi, you can run these commands and further configure the clock display.

`pm2 start MagicMirror` - Run MagicMirror

`pm2 reload MagicMirror` - Reload MagicMirror (if auto reloading after editing the config is not enabled)

`pm2 stop MagicMirror` - Stop MagicMirror

<sub>More commands and documentation for `pm2` can be found [here](https://pm2.keymetrics.io/docs/usage/pm2-doc-single-page/)</sub>

#### Features

- Two display modes: `Clock` and `Informational`
  - Normally, the display will default to `Clock`, showing a large clock display with the [Planetarium](https://github.com/MMRIZE/MMM-Planetarium) display in the background
  - The `Informational` display will come out when you tap the screen, showing information from the modules listed below
    - This display will go back to the `Clock` display after 10 seconds
    - It will also automatically stay up from 10:30am - 11:30am
- Modules
  - _TODO: list the modules_

_TODO: showcase photos and videos_

### Screen Orientation

<sub>Via the [Pi-Kiosk repo](https://github.com/geerlingguy/pi-kiosk?tab=readme-ov-file#rotating-the-screen)</sub>

Running this command will turn the screen 90 (or change to whichever you want) degrees.

```bash
wlr-randr --output DSI-1 --transform 90
```

If you want it to persist, you can do so by changing the `transform` argument in the `~/.config/kanshi/config` file, like so:

```
profile {
    output HDMI-A-1 enable mode 1280x720@100.000 position 0,0 transform 270
}
```

It can also be done by manually changing the screen orientation in the rpi's desktop screen configurations. (I found better results doing it this way)

### Auto dimming

Coming soon!

To change the brightness manually (without the use of a sensor), run the command:

```bash
echo <VALUE> > /sys/class/backlight/<monitor>/brightness
```

Where `VALUE` is an integer between 0 - 31 (with 0 being off and 31 being max brightness)

and `MONITOR` is the display the Raspberry Pi is using (it can most likely be tab completed)

### Temperature Monitoring

Coming soon!

## Tips and Tricks

Some information that isn't completely necessary for the build/project, but still nice to include anyways!

### View CPU temperature

Although the pi's current temperature is displayed on screen (in the botton left), it can also be viewed remotely/through a script with the command:

```bash
vcgencmd measure_temp
```

### Reduce shutdown power consumption

Follow the instructions found [here](https://github.com/geerlingguy/pi-kiosk/tree/master?tab=readme-ov-file#reduce-shutdown-power-consumption-by-140x) to reduce
the pi's power consumption while it is powered off by 140x!.

### Turn off LED power light

The red light can get annoying in the dark (especially without a case), so there's an easy way to turn it off:

```bash
echo 0 | sudo tee /sys/class/leds/PWR/brightness
```

To not run this command every single time the Raspberry Pi boots up, you can have it do it for you by adding this line to your `/etc/crontab`

```
@reboot root echo 0 > /sys/class/leds/PWR/brightness
```

<sub>Thanks to [this post](https://forums.raspberrypi.com/viewtopic.php?t=252049)</sub>

# Credits

[The Pi Kiosk project](https://github.com/geerlingguy/pi-kiosk)

- Use of many of it's commands and features to setup the Raspberry Pi

More coming soon!
