{-
#include <X11/XF86keysym.h>
-}

import XMonad
import XMonad.StackSet
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

import XMonad.Layout.Tabbed

myManageHook = composeAll
               [ className =? "Firefox" --> doShift "1"
               , className =? "Emacs" --> doShift "2"
               ] 
               <+> 
               composeOne [ isFullscreen -?> doFullFloat ]
               <+>
               scratchHook
-- scratchpadManageHookDefault

scratchHook = scratchpadManageHook (RationalRect l t w h)
  where
    h = 0.3     -- terminal height, 10%
    w = 1       -- terminal width, 100%
    t = 0.67   -- distance from top edge, 90%
    l = 1 - w   -- distance from left edge, 0%

tabbedLayout = simpleTabbedAlways ||| Full

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
                        , ppTitle = xmobarColor "#dfaf8f" "" . shorten 50
                        , ppUrgent =xmobarColor "#ac7373" "black" . xmobarStrip
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

