-- XMonad configuration
-- Author: albertb@gmail.com (Albert Bachand)

import XMonad

import qualified Data.Map as M

main :: IO ()
main = xmonad $ defaultConfig
    { keys = myKeys
    , layoutHook = myLayoutHook
    , manageHook = myManageHook
    , modMask = myModMask
    , terminal = myTerminal
    , workspaces = myWorkspaces
    }

-- TODO: h, t?
myKeys :: XConfig Layout -> Map (KeyMask, KeySym) (X ())
myKeys conf@(Xconfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((myModMask              , xK_a     ), refresh)
    , ((myModMask .|.          , xK_c     ), kill)
    , ((myModMask              , xK_d     ), sendMessage Shrink)
    , ((myModMask              , xK_f     ), withFocused $ windows . W.sink)
    , ((myModMask              , xK_n     ), sendMessage Expand)
    , ((myModMask .|. shiftMask, xK_q     ), spawn "gnome-session-save --gui --kill")
    , ((myModMask              , xK_q     ), restart "xmonad" True)
    , ((myModMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((myModMask              , xK_r     ), spawn "gmrun")
    , ((myModMask              , xK_s     ), sendMessage NextLayout)
    , ((myModMask .|. shiftMask, xK_s     ), setLayout $ XMonad.layoutHook conf)
    , ((myModMask              , xK_space ), sendMessage NextLayout)
    , ((myModMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((myModMask              , xK_Tab   ), windows W.focusDown)
    , ((myModMask .|. shiftMask, xK_Tab   ), windows W.focusUp)
    , ((myModMask              , xK_v     ), sendMessage (IncMasterN (-1)))
    , ((myModMask              , xK_w     ), sendMessage (IncMasterN 1))
    , ((myModMask              , xK_x     ), spawn "xlock")
    ]
    ++
    [((m .|. myModMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

myLayoutHook = tiled ||| Mirror tiled ||| Full
    where tiled = Tall 1 (3 / 100)

myManageHook :: [ManageHook]
myManageHook = []

myModMask :: KeySym
myModMask = mod4Mask

myTreminal :: String
myTerminal = "urxvt"

myWorkspaces :: [WorkspaceID]
myWorkspaces = ['α'..'κ']  -- FIXME
