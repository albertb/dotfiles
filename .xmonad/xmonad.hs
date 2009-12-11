-- XMonad configuration
-- Author: albertb@gmail.com (Albert Bachand)

import XMonad
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

main :: IO ()
main = xmonad $ defaultConfig
    { keys = myKeys
    , layoutHook = myLayoutHook
    , modMask = myModMask
    , terminal = myTerminal
    , workspaces = myWorkspaces
    }

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask              , xK_a     ), refresh)
    , ((modMask              , xK_c     ), kill)
    , ((modMask              , xK_d     ), sendMessage Shrink)
    , ((modMask              , xK_f     ), withFocused $ windows . W.sink)
    , ((modMask .|. shiftMask, xK_h     ), windows W.focusDown)
    , ((modMask              , xK_n     ), sendMessage Expand)
    , ((modMask .|. shiftMask, xK_q     ), spawn "gnome-session-save --gui --kill")
    , ((modMask              , xK_q     ), restart "xmonad" True)
    , ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modMask              , xK_r     ), spawn "gmrun")
    , ((modMask              , xK_s     ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_s     ), setLayout $ XMonad.layoutHook conf)
    , ((modMask              , xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask              , xK_Tab   ), windows W.focusDown)
    , ((modMask .|. shiftMask, xK_Tab   ), windows W.focusUp)
    , ((modMask .|. shiftMask, xK_t     ), windows W.focusUp)
    , ((modMask              , xK_v     ), sendMessage (IncMasterN (-1)))
    , ((modMask              , xK_w     ), sendMessage (IncMasterN 1))
    , ((modMask              , xK_x     ), spawn "xlock")
    ]
    ++
    [((m .|. myModMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

myLayoutHook = tiled ||| Mirror tiled ||| Full
    where tiled = Tall 1 (3 / 100) (1 / 2)

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "urxvt"

myWorkspaces :: [WorkspaceId]
myWorkspaces = [x:[] | x <- ['α'..'κ']]
