{-
#include <X11/XF86keysym.h>
-}

import XMonad
import XMonad.StackSet
import XMonad.Actions.Search
import XMonad.Prompt
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Scratchpad
import System.IO
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import Data.Monoid
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Tabbed


myManageHook = composeAll
               [ className =? "Firefox" --> doShift "1:www"
               , className =? "Xpdf" --> doShift "4:pdf"
               ] 
               <+> 
               composeOne [ isFullscreen -?> doFullFloat ]
               <+>
               scratchHook

myWorkspaces = ["1:www", "2:emacs", "3:sh", "4:pdf", "5", "6", "7", "8:gnus", "9:mpd"]

scratchHook = scratchpadManageHook (RationalRect l t w h)
  where
    h = 0.3     -- terminal height, 10%
    w = 1       -- terminal width, 100%
    t = 0.67   -- distance from top edge, 90%
    l = 1 - w   -- distance from left edge, 0%

myLayout = (onWorkspace "4:pdf" (smartBorders $ simpleTabbedAlways))
           $ (onWorkspace "3:sh" (avoidStruts $ smartBorders $ Grid))
           $ (onWorkspace "8:gnus" (avoidStruts $ imLayout))
           $ smartBorders
           $ avoidStruts 
           $ standardLayouts
    where
      standardLayouts = (layoutHook defaultConfig)
      nmaster = 1
      delta   = 3/100
      ratio   = 1/2
      imLayout = withIM (1/10) (ClassName "Skype") (Tall nmaster delta ratio)
               
-- main = xmonad $ ewmh defaultConfig{  }
main = do
    xmproc <- spawnPipe "xmobar ~/.xmobarrc"
    xmonad $ ewmh defaultConfig
        {
	  terminal                 = "urxvt"
        , XMonad.workspaces        = myWorkspaces
	, manageHook               = manageDocks <+> myManageHook <+> manageHook defaultConfig -- managedocks für gap
        , startupHook              = setWMName "LG3D"
 	, layoutHook               = myLayout
        , logHook                  = dynamicLogWithPP $ xmobarPP
                                     { ppOutput = hPutStrLn xmproc
                                     , ppTitle  = xmobarColor "#dfaf8f" "" . shorten 50
                                     , ppUrgent =xmobarColor "#ac7373" "black" . xmobarStrip
                                     }
        , modMask                  = mod4Mask
        , handleEventHook          = handleEventHook defaultConfig <+> fullscreenEventHook
        } `additionalKeys`
        [ 
          ((mod4Mask .|. shiftMask, xK_z), spawn "slimlock") -- meta shift z 
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
        , ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((mod4Mask, xK_s), spawn "xinput set-int-prop 13 \"Device Enabled\" 8 0")
        , ((mod4Mask .|. shiftMask, xK_s), spawn "xinput set-int-prop 13 \"Device Enabled\" 8 1")
        , ((mod4Mask, xK_p), spawn "dmenu_run")
        ]
