{-
#include <X11/XF86keysym.h>
-}

import XMonad
import XMonad.Actions.Search
import XMonad.Prompt
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.NoBorders
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Scratchpad
import System.IO
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import Data.Monoid

myManageHook = composeAll
               [ className =? "Firefox" --> doShift "1"
               , className =? "Emacs" --> doShift "2"
               ] 
               <+> 
               composeOne [ isFullscreen -?> doFullFloat ]
               <+>
               scratchpadManageHookDefault

main = do
    xmproc <- spawnPipe "xmobar /home/boots/.xmobarrc"
    xmonad $ withUrgencyHook NoUrgencyHook defaultConfig
        {
	  terminal    = "urxvt"
	, manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig -- managedocks für gap
        , startupHook = setWMName "LG3D"
 	, layoutHook = smartBorders $ avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "red" "" . shorten 50
                        , ppUrgent =xmobarColor "red" "black" . xmobarStrip
                        }
        , modMask = mod4Mask
        } `additionalKeys`
        [ 
          ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock") -- meta shift z 
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s") -- print --> screenshot
        , ((0, 0x1008ff15), spawn "mpc stop")
        , ((0, 0x1008ff16), spawn "mpc prev")
        , ((0, 0x1008ff17), spawn "mpc next")
        , ((0, 0x1008ff12), spawn "mpc volume 0")
        , ((0, 0x1008ff11), spawn "mpc volume -4")
        , ((0, 0x1008ff13), spawn "mpc volume +4")
        , ((0, 0x1008ff14), spawn "mpc toggle")
        , ((mod4Mask .|. shiftMask, xK_n), scratchpadSpawnActionTerminal "urxvt")
        , ((mod4Mask, xK_o), promptSearch greenXPConfig google)
        , ((mod4Mask .|. shiftMask, xK_b), focusUrgent)
        ]

