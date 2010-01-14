-- XMonad configuration
-- Author: albertb@gmail.com (Albert Bachand)

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import System.Exit
import System.IO

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

main :: IO ()
main = xmonad =<< xmobar defaultConfig
    { keys = myKeys
    , layoutHook = myLayoutHook
    , manageHook = manageDocks <+> manageHook defaultConfig
    , modMask = myModMask
    , terminal = myTerminal
    , workspaces = myWorkspaces
    }

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask              , xK_a     ), refresh)
    , ((modMask .|. shiftMask, xK_c     ), kill)
    , ((modMask              , xK_d     ), sendMessage Shrink)
    , ((modMask              , xK_f     ), withFocused $ windows . W.sink)
    , ((modMask              , xK_h     ), windows W.focusDown)
    , ((modMask              , xK_n     ), sendMessage Expand)
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modMask              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    , ((modMask              , xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modMask              , xK_r     ), spawn "gmrun")
    , ((modMask              , xK_s     ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_s     ), setLayout $ XMonad.layoutHook conf)
    , ((modMask              , xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask              , xK_Tab   ), windows W.focusDown)
    , ((modMask .|. shiftMask, xK_Tab   ), windows W.focusUp)
    , ((modMask              , xK_t     ), windows W.focusUp)
    , ((modMask              , xK_v     ), sendMessage (IncMasterN (-1)))
    , ((modMask              , xK_w     ), sendMessage (IncMasterN 1))
    , ((modMask              , xK_x     ), spawn "xlock")
    ]
    ++
    [((m .|. myModMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

myLayoutHook = avoidStruts $ tiled ||| Mirror tiled ||| Full
    where tiled = Tall 1 (3 / 100) (1 / 2)

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "gnome-terminal"  -- FIXME: setup antialias in urxvt

myWorkspaces :: [WorkspaceId]
myWorkspaces = [show x | x <- [1..9]]