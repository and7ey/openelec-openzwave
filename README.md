Open-ZWave addon for OpenELEC/Kodi
==================

OpenELEC - http://openelec.tv/
Kodi - https://kodi.tv/
Open-ZWave - https://github.com/OpenZWave/open-zwave

Simple addon to switch all nodes on/off.

I am failed to compile [python-openzwave](https://github.com/OpenZWave/python-openzwave) (see the problem description [here](http://stackoverflow.com/questions/37731787/how-to-work-with-c-library-from-python), so this is based on C++ app with many commands (SwitchAllOff/SwitchAllOn) hardcoded.

Please note: SwitchAllOn is not supported by some devices. Switching the light on and off takes some time (since open-zwave discovers all nodes first).

I use this addon with my remote (see [Keymaps](http://kodi.wiki/view/Keymaps)) to switch on the light on the Home screen by pressing button :one: and to switch it off with button :two::
```
<?xml version="1.0" encoding="UTF-8"?>
<keymap>
  <home>
    <remote>
      <one>RunScript("script.open-zwave.switchall", 1)</one>
      <zero>RunScript("script.open-zwave.switchall", 0)</zero>
    </remote>
  </home>
</keymap>
```

## Script verification
You may test how the script works either from the Settings menu or manually thru SSH connection to your OpenELEC device:
```
LD_LIBRARY_PATH="/storage/.kodi/addons/service.multimedia.open-zwave/bin" ~/.kodi/addons/service.multimedia.open-zwave/bin/ozw-power-on-off.out /dev/
ttyUSB0 1 1
```
The first command line parameters defines USB stick port, the second indicates of open-zwave should display log in console (very useful when you would like to see node reply) and the last one indicates if the light should be switched on (1) or off (0).

You may also use `MinOZW` app to see what happens in your Z-Wave network (for ex., may help you to identify USB stick port):
```
LD_LIBRARY_PATH="/storage/.kodi/addons/service.multimedia.open-zwave/bin" ~/.kodi/addons/service.multimedia.open-zwave/bin/MinOZW
```
