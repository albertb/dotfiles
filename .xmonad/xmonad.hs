-- XMonad configuration
-- Author: albertb@gmail.com (Albert Bachand)

import XMonad
import XMonad.Config.Gnome
import XMonad.Layout.DwmStyle
import XMonad.Layout.WindowNavigation
import qualified XMonad.StackSet as W

import qualified Data.Map as M
import System.Exit

myModMask = mod4Mask

myLayoutHook = dwmStyle shrinkText defaultTheme (windowNavigation (layoutHook gnomeConfig))

-- dvorak mappings
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((myModMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((myModMask              , xK_r     ), spawn "gmrun")
    , ((myModMask .|. shiftMask, xK_c     ), kill)
    , ((myModMask              , xK_space ), sendMessage NextLayout)
    , ((myModMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((myModMask              , xK_a     ), refresh)
    , ((myModMask              , xK_Tab   ), windows W.focusDown)
    , ((myModMask              , xK_h     ), windows W.focusDown)
    , ((myModMask              , xK_t     ), windows W.focusUp)
    , ((myModMask              , xK_m     ), windows W.focusMaster)
    , ((myModMask              , xK_Return), windows W.swapMaster)
    , ((myModMask .|. shiftMask, xK_h     ), windows W.swapDown)
    , ((myModMask .|. shiftMask, xK_t     ), windows W.swapUp)
    , ((myModMask              , xK_d     ), sendMessage Shrink)
    , ((myModMask              , xK_n     ), sendMessage Expand)
    , ((myModMask              , xK_f     ), withFocused $ windows . W.sink)
    , ((myModMask              , xK_w     ), sendMessage (IncMasterN 1))
    , ((myModMask              , xK_v     ), sendMessage (IncMasterN (-1)))
    , ((myModMask .|. shiftMask, xK_q     ), spawn "gnome-session-save --gui --kill")
    , ((myModMask              , xK_q     ), restart "xmonad" True)
    , ((myModMask              , xK_x     ), spawn "xlock")
    , ((myModMask,                 xK_Right), sendMessage $ Go R)
    , ((myModMask,                 xK_Left ), sendMessage $ Go L)
    , ((myModMask,                 xK_Up   ), sendMessage $ Go U)
    , ((myModMask,                 xK_Down ), sendMessage $ Go D)
    , ((myModMask .|. controlMask, xK_Right), sendMessage $ Swap R)
    , ((myModMask .|. controlMask, xK_Left ), sendMessage $ Swap L)
    , ((myModMask .|. controlMask, xK_Up   ), sendMessage $ Swap U)
    , ((myModMask .|. controlMask, xK_Down ), sendMessage $ Swap D)
    ]
    ++
    [((m .|. myModMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

main = xmonad $ gnomeConfig
     { modMask = myModMask
     , layoutHook = myLayoutHook
     , keys = myKeys
     , normalBorderColor = "#000022"
     , focusedBorderColor = "#33CCFF"
     }

