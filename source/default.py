# -*- coding: utf-8 -*-

import xbmc
import xbmcaddon
import os
import sys

__addon__               = xbmcaddon.Addon()
__addon_id__            = __addon__.getAddonInfo('id')
__addonname__           = __addon__.getAddonInfo('name')
__icon__                = __addon__.getAddonInfo('icon')
__addonpath__           = xbmc.translatePath(__addon__.getAddonInfo('path'))
__lang__                = __addon__.getLocalizedString

class SwitchAll:
    
    def __init__(self):
    
        self.debug('Script initiated')
        if len(sys.argv) == 2 and sys.argv[1] == "1":
            self.SwitchAll(True)
        else:
            self.SwitchAll(False)
    
    def SwitchAll(self, onoff):
        if onoff == True:
            self.notify(__lang__(32001))
            self.debug('Switching the light on...')
        else: 
            self.notify(__lang__(32002))
            self.debug('Switching the light off...')
        
	ld_lib_string = 'LD_LIBRARY_PATH="'+__addonpath__+'/bin"'
        self.debug(ld_lib_string)
        os.system(ld_lib_string)

        execute_string = __addonpath__+'/bin/ozw-power-on-off.out '+__addon__.getSetting('port')+' '+str(int(onoff))+' 0' # usb device port, on(1)/off(0), logging(1)/no logging(0)
        self.debug(execute_string)
        os.system(execute_string) 
        return
            
    def debug(self, msg):
        if 'true' in __addon__.getSetting('debug'):
        	xbmc.log('>>>> ' + __addonname__ + ' <<<< ' + msg)
        
    def notify(self, msg):
        if 'true' in __addon__.getSetting('notify'):
        	xbmc.executebuiltin('Notification(' + __addonname__ + ', ' + msg.encode('utf-8') + ', 8000, ' + __icon__ + ')')
        
SwitchAll()
